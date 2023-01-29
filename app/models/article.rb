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

  validates :question, presence:true, length: { maximum: 200 }
  validates :answer, length: { maximum: 200 }

  #ログイン中のユーザーに高評価されているか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def unfavorited_by?(user)
    unfavorites.where(user_id: user.id).exists?
  end

  #検索された単語を引数に、投稿を探すメソッド
  def self.looks(word)
    @article = Article.where("question LIKE?","%#{word}%")
  end

end
