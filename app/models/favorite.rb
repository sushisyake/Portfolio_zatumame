class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :article
  validates_uniqueness_of :article_id, scope: :customer_id
end
