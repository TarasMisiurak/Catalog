class User < ActiveRecord::Base
	resourcify
  	rolify
	has_many :posts
	has_many :favorite_posts
	has_many :favorites, through: :favorite_posts, source: :post
	has_many :comments

	has_attached_file :avatar, styles: { thumb: "32x32#", small: "64x64#", medium: "350x350#", large: "700x700>" },
					:url  => "/assets/users/:id/:style/:basename.:extension",
                  	:path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

	validates_attachment_size :avatar, :less_than => 5.megabytes

	validates :username, presence: true

	validates_attachment :avatar,
                     content_type: { content_type: ["image/jpeg", "image/png"] }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
