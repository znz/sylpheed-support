require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "save an article" do
    article = Article.new(remote_addr: '::1', name: 'name', subject: 'subject', body: 'body')
    article.set_ids
    article.save!
  end
end
