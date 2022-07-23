class Book < ApplicationRecord

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_one :view_count, dependent: :destroy


  #favorited_usersは、favoritesテーブルを通って、userモデルのデータ持ってくる
  has_many :favorited_users, through: :favorites, source: :user


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
