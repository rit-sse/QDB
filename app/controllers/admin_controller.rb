class AdminController < ApplicationController
	http_basic_authenticate_with :name => APP_CONFIG["mod_user"], :password => APP_CONFIG["mod_pass"], :except => []
	
	def index
		@quotes = Quote.where(:approved => nil).all
		respond_to do |format|
			format.html
			format.json {render json: @quotes}
		end
	end

	def approve
		quote = Quote.find(params[:id])
		quote.approved = true
		quote.save

		redirect_to "#{config.relative_url_root}/admin"
	end

	def deny
		quote = Quote.find(params[:id])
		quote.approved = false
		quote.save

		redirect_to "#{config.relative_url_root}/admin"
	end

	def rss
		@quotes = Quote.where(:approved => nil).all
		render "to_mod.rss.builder"
	end
end
