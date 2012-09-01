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

	def search(query)
		results = Set.new Quote.where("body LIKE ? OR description LIKE ?", query, query).all
		tags = Tag.where("name LIKE ?", query)
		tags.each do |tag|
			results.merge(tag.quotes)
		end
		results
	end
end
