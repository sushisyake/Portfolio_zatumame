class Article < ApplicationRecord

  belongs_to :customer
  
  validates :question, presence:true
  validates :answer, presence:true
  
end
