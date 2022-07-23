class Relationship < ApplicationRecord
  # follwer/follwedは別名、 user tableを見に行く
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
