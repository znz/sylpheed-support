class Article < ApplicationRecord
  acts_as_nested_set counter_cache: :children_count

  validates :remote_addr, presence: true
  validates :name, :subject, :body, presence: true
  validates :name, length: { maximum: 30 }
  validates :subject, length: { maximum: 50 }
  validates :body, length: { maximum: 2000 }
  validates :mail_addr, length: { maximum: 100 }
  validates :url, length: { maximum: 100 }

  validates :article_id, :pthread_id, presence: true

  NEW_ARTICLE_TIME = 24
  ARTICLE_MAX = 100

  def commentable?
    root.self_and_descendants.count < ARTICLE_MAX
  end

  def set_ids
    parent = self.parent
    if parent
      if !parent.commentable?
        return false
      end
      self.pthread_id = parent.pthread_id
      self.article_id = parent.self_and_descendants.count + 1
    else
      self.pthread_id = Article.roots.count + 1
      self.article_id = 1
    end
    true
  end
end
