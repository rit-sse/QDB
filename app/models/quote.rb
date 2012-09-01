class Quote < ActiveRecord::Base
  attr_accessible :approved, :body, :deleted, :description, :flagged
  has_and_belongs_to_many :tags

  default_scope :order => "created_at DESC"
end
