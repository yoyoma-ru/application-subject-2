class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false

  #フォローできるユーザーを取り出す記述
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  #フォローしているユーザーを取り出す記述
  has_many :followings, through: :following_relationships
  # フォローされているユーザーを取り出す
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  # フォローしているか調べる関数
  def following?(other_user)
  	following_relationships.find_by(following_id: other_user.id)
  end
  # フォローする関数
  def follow!(other_user)
  	following_relationships.create!(following_id: other_user.id)
  end
  # フォローを外す関数
  def unfollow!(other_user)
  	following_relationships.find_by(following_id: other_user.id).destroy
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
