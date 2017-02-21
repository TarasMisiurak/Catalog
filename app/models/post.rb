class Post < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :favorite_posts
	has_many :favorited_by, through: :favorite_posts, source: :user
	has_many :comments, as: :commentable
	has_many :cart_items

	default_scope { where(active: true) }

	has_attached_file :image, styles: { thumb: "64x64#", small: "100x100#", medium: "350x350#", large: "700x700>" },
					:url  => "/assets/posts/:id/:style/:basename.:extension",
                  	:path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

	validates_attachment_size :image, :less_than => 5.megabytes

	validates :category, presence: true

	validates :title, presence: true, length: { minimum: 5 }

	validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/png"] }

    #validates :price, numericality: { greater_than: 0 }

end
