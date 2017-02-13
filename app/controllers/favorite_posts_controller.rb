class FavoritePostsController < ApplicationController
	load_and_authorize_resource
	
	def index
		@post = Post.find(params[:id])
	end

end
