class PagesController < ApplicationController

	def welcome
		render layout: 'landing'
	end

end
