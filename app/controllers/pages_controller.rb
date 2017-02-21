class PagesController < ApplicationController

	def welcome
		render layout: 'landing'
	end

	def about
		render pages: 'about'
	end

	def contact
		render pages: 'contact'
	end

end
