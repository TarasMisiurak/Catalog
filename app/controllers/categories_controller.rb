class CategoriesController < ApplicationController

	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		@category.save
		render :show
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category.update_attributes(category_params)
		redirect_to categories_path(@category)
	end

	def show
		@category = Category.find(params[:id])
		@posts = Post.where(category_id: @category.id)
	end

	def destroy
	end

	def category_params
		params.require(:category).permit(:name, :desc)
	end

end
