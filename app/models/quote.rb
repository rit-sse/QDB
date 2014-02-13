class Quote < ActiveRecord::Base
  attr_accessible :approved, :body, :deleted, :description, :flagged
  attr_accessible :url
  attr_accessor :url
  has_and_belongs_to_many :tags

  validate do |quote|
    if !(url.nil? || url.empty?)
      errors[:url] << "Stop spamming the QDB!"
    end
  end

  default_scope :order => "id DESC"

  def as_json(options = { })
    h = super(options)
    h["tags"] = tags.map(&:name).join(",")
    h
  end
end
