require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body: @article.body, mail_addr: @article.mail_addr, name: @article.name, subject: @article.subject, url: @article.url } }
    end

    assert_redirected_to article_url(Article.order(:created_at).last)
  end

  test "should not create article" do
    (2..Article::ARTICLE_MAX).each do
      article = Article.new(parent_id: @article.id, body: @article.body, mail_addr: @article.mail_addr, name: @article.name, subject: @article.subject, url: @article.url, remote_addr: @article.remote_addr)
      article.set_ids
      article.save!
    end
    @article.reload
    assert_equal Article::ARTICLE_MAX, @article.self_and_descendants.count

    assert_no_difference('Article.count') do
      post articles_url, params: { article: { parent_id: @article.id, body: @article.body, mail_addr: @article.mail_addr, name: @article.name, subject: @article.subject, url: @article.url } }
    end

    assert_redirected_to article_url(@article)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { article_id: @article.article_id, body: @article.body, delete_flg: @article.delete_flg, mail_addr: @article.mail_addr, name: @article.name, password: @article.password, pthread_id: @article.pthread_id, remote_addr: @article.remote_addr, subject: @article.subject, url: @article.url } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
