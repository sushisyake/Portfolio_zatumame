class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  #１つの投稿に対して、ユーザーは一度しか高評価できない
  validates_uniqueness_of :article_id, scope: :user_id
end
