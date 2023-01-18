class ArticleComment < ApplicationRecord
    belongs_to :user
    belongs_to :article
    
    validates :comment, presence: true
end
