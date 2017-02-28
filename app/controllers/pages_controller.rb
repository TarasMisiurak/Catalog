class PagesController < ApplicationController

	def welcome
		@recent_posts = Post.order("created_at DESC").limit(4)
		render layout: 'landing'
	end

	def about
		render pages: 'about'
	end

	def contact
		render pages: 'contact'
	end

end
