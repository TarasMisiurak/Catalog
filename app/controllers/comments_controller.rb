class CommentsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user = current_user
		@comment.save
		redirect_to @commentable, notice: "Your comment was posted successfully!"
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash.now[:notice] = "Successfully updated comment!"
			redirect_to post_path(@post)
		else
			flash.now[:alert] = "Error updating comment!"
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @comment.destroy
			flash.now[:notice] = "Comment removed"
			redirect_to post_path(@post)
		else
			flash.now[:notice] = "Error!"
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end
