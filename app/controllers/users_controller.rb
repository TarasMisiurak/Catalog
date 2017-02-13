class UsersController < ApplicationController
	load_and_authorize_resource
	
	def show
		@user = User.find(params[:id])
		@posts = @user.posts
		@favorite_posts = @user.favorites
	end

end
