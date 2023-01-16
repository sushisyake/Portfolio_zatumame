class Article < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy

  validates :question, presence:true
  validates :answer, presence:true

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
