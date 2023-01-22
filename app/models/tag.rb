class Tag < ApplicationRecord

  # 以下を追記
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :article_tag_relations, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してArticleテーブルへの関連付け
  has_many :articles, through: :article_tag_relations, dependent: :destroy

  validates :name, length: { maximum: 20 }, uniqueness: true, presence: true
end