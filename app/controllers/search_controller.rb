class SearchController < ApplicationController
	def create
		@results = self.search(params[:query])
		@query = params[:query]
		render :results
	end

	def show
		@results = self.search(params[:id])
		@query = params[:id]
		render :results
	end

	def index
		@results = self.search(params[:id])
		@query = params[:query]
		render :results
	end

	def search(query)
		Quote.where(:approved => true).where("body LIKE ? or description LIKE ?", "%#{query}%", "%#{query}%").page params[:page]
	end
end
