class User < ActiveRecord::Base
	has_many :posts
	has_many :favorite_posts
	has_many :favorites, through: :favorite_posts, source: :post
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
