class AdminController < ApplicationController
	http_basic_authenticate_with :name => APP_CONFIG["mod_user"], :password => APP_CONFIG["mod_pass"], :except => []
	
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
