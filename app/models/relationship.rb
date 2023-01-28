class Relationship < ApplicationRecord
  #どちらもユーザーとのアソシエーションを定義している
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
