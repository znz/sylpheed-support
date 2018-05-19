require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "save an article" do
    article = Article.new(remote_addr: '::1', name: 'name', subject: 'subject', body: 'body')
    article.set_ids
    article.save!
  end

  test "do not update updated_at of left tree" do
    article1 = Article.new(remote_addr: '::1', name: 'name 1', subject: 'subject 1', body: 'body 1')
    article1.set_ids
    article1.save!
    article2 = Article.new(remote_addr: '::1', name: 'name 2', subject: 'subject 2', body: 'body 2')
    article2.set_ids
    article2.save!
    updated_at_1 = article1.updated_at
    updated_at_2 = article2.updated_at
    article3 = Article.new(parent_id: article1.id, remote_addr: '::1', name: 'name 3', subject: 'subject 3', body: 'body 3')
    article3.set_ids
    article3.save!
    article2.reload
    assert_equal updated_at_2, article2.updated_at, 'https://github.com/collectiveidea/awesome_nested_set/issues/389'
  end

  test "update updated_at of parent" do
    article1 = Article.new(remote_addr: '::1', name: 'name 1', subject: 'subject 1', body: 'body 1')
    article1.set_ids
    article1.save!
    article2 = Article.new(remote_addr: '::1', name: 'name 2', subject: 'subject 2', body: 'body 2')
    article2.set_ids
    article2.save!
    updated_at_1 = article1.updated_at
    updated_at_2 = article2.updated_at
    article3 = Article.new(parent_id: article1.id, remote_addr: '::1', name: 'name 3', subject: 'subject 3', body: 'body 3')
    article3.set_ids
    article3.save!
    article1.reload
    assert_not_equal updated_at_1, article1.updated_at
  end
end
