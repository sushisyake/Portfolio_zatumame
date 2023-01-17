class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :last_name, length: { maximum: 10 }, presence: true
  validates :first_name, length: { maximum: 10 }, presence: true
  validates :last_name_kana, length: { maximum: 10 }, presence: true
  validates :first_name_kana, length: { maximum: 10 }, presence: true
  validates :nickname, length: { maximum: 10 }, uniqueness: true, presence: true
  validates :introduction, length: { maximum: 100 }

    # フォローしたときの処理
  def follow(customer_id)
    #byebug
    relationships.create!(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end

end
