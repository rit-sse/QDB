class AdminController < ApplicationController
	def index
		@quotes = Quote.where(:approved => nil).all
	end

	def approve
		quote = Quote.find(params[:id])
		quote.approved = true
		quote.save

		redirect_to "/admin"
	end

	def deny
		quote = Quote.find(params[:id])
		quote.approved = false
		quote.save

		redirect_to "/admin"
	end
end
