class Quote < ActiveRecord::Base
  attr_accessible :approved, :body, :deleted, :description, :flagged
  has_and_belongs_to_many :tags

  default_scope :order => "id DESC"

  def as_json(options = { })
    h = super(options)
    h["tags"] = tags.map(&:name).join(",")
    h
  end
end
