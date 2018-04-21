class Article < ApplicationRecord
  acts_as_nested_set counter_cache: :children_count

  validates :remote_addr, presence: true
  validates :name, :subject, :body, presence: true
  validates :name, length: { maximum: 30 }
  validates :subject, length: { maximum: 50 }
  validates :body, length: { maximum: 2000 }
  validates :mail_addr, length: { maximum: 100 }
  validates :url, length: { maximum: 100 }

  NEW_ARTICLE_TIME = 24
  ARTICLE_MAX = 100
end
