class Topic < ApplicationRecord
  validates :body, presence: true

  def self.most_recent
    where(delete_flg: false).order(:updated_at).last
  end
end
