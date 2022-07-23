class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  #belongs_to :books
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #follow
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  
  # フォローされてばtrueを返す
  def follower?(user)
    follower_user.include?(user)
  end

  #　チャット用
  has_many :chats,dependent: :destroy

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
