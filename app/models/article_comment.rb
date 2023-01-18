class ArticleComment < ApplicationRecord
    belongs_to :customer
    belongs_to :article
    
    validates :comment, presence: true
end
