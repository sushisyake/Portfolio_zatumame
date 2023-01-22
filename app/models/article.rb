class Article < ApplicationRecord

  belongs_to :user
  belongs_to :genre, optional: true
  has_many :favorites, dependent: :destroy
  has_many :article_comments, dependent: :destroy

  validates :question, presence:true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
