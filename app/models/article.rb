class Article < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :unfavorites, dependent: :destroy
  has_many :article_comments, dependent: :destroy
   #articlesテーブルから中間テーブルに対する関連付け
  has_many :article_tag_relations, dependent: :destroy
  #articlesテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :article_tag_relations, dependent: :destroy

  validates :question, presence:true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def unfavorited_by?(user)
    unfavorites.where(user_id: user.id).exists?
  end

  def self.looks(word)
    @article = Article.where("question LIKE?","%#{word}%")
  end

end
