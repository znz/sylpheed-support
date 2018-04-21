require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "most recent" do
    one = topics(:one)
    two = topics(:two)
    one.body += ' (modified)'
    one.save!
    assert_equal one, Topic.most_recent
    two.body += ' (modified)'
    two.save!
    assert_equal two, Topic.most_recent
    two.delete_flg = true
    two.save!
    assert_equal one, Topic.most_recent
  end
end
