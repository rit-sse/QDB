class Tag < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :quotes

  def showable?
  	if self.quotes.size == 0
  		return false
  	end

  	self.quotes.each do |quote|
  		if !(quote.approved == nil)  && quote.approved
  			return true
  		end
  	end

  	return false

  end
end
