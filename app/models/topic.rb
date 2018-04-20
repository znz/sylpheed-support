class Topic < ApplicationRecord
  validates :body, presence: true
end
