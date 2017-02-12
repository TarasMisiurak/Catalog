class PostsController < ApplicationController

	def index
		@posts = Post.order('created_at DESC')
	end

	def new
		@post = Post.new
		@categories = Category.all.map{|c| [ c.name, c.id ] }
	end

	def create
		@post = Post.new(post_params)
		@post.category_id = params[:category_id] 
		@post.user_id = current_user.id
		if @post.save
			flash.now[:notice] = "Created a post"
			redirect_to @post
		else
			flash.now[:alert] = "Error saving post!"
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
		@categories = Category.all.collect{|c| [ c.name, c.id ] }
	end

	def update
		@categories = Category.all.map{|c| [ c.name, c.id ] }
		@post = Post.find_by_id(params[:id])
		@post.category_id = params[:category_id]
		@post.user_id = current_user.id
		if @post.update_attributes(post_params)
			flash.now[:notice] = "Successfully updated post!"
			redirect_to post_path(@post)
		else
			flash.now[:alert] = "Error updating post!"
			render :edit
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def favorite
		type = params[:type]
		if type == "favorite"
			current_user.favorites << @post
			redirect_to :back, notice: "Added #{@post.title} to favorites"
		elsif type == "unfavorite"
			current_user.favorites.delete(@post)
			redirect_to :back, notice: "Removed #{@post.title} from favorites"
		else
			redirect_to :back, notice: "Nothing"
		end	
	end

	def destroy
		if @post.destroy
			flash.now[:notice] = 'Post deleted!'
			redirect_to posts_path
		else
			flash.now[:alert] = 'Error!'
		end
	end

	def delete_image
		@post = Post.find(params[:id])
		@post.image = nil
		@post.save
		redirect_to @post
	end

	private

	def post_params
		params.require(:post).permit(:title, :body, :image, :user_id)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
