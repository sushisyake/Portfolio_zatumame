class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy

  validates :last_name, length: { maximum: 10 }, presence: true
  validates :first_name, length: { maximum: 10 }, presence: true
  validates :last_name_kana, length: { maximum: 10 }, presence: true
  validates :first_name_kana, length: { maximum: 10 }, presence: true
  validates :nickname, length: { maximum: 10 }, uniqueness: true, presence: true
  validates :introduction, length: { maximum: 100 }

end
