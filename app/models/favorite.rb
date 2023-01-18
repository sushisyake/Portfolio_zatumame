class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates_uniqueness_of :article_id, scope: :user_id
end
