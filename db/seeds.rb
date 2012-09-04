# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'
require 'pp'

json = JSON.parse(File.read("#{Rails.root}/db/chirpy_quotes.json"))
json.each do |elem|
	quote = Quote.new()
	#puts "#{quote.id} + #{elem["id"]} - #{elem["body"]}"
	quote.id = elem["id"]
	quote.body = elem["body"].sub("<%newline%>", "\r") if elem["body"]
	quote.description = elem["notes"].sub("<%newline%>", "\r") if elem["notes"]
	quote.rating = elem["rating"]
	quote.created_at = DateTime.parse(elem["submitted"])
	quote.updated_at = DateTime.parse(elem["submitted"])
	quote.approved = (elem["approved"] == 1)
	quote.flagged = (elem["flagged"] == 1)
	quote.save
end

json = JSON.parse(File.read("#{Rails.root}/db/chirpy_tags.json"))
json.each do |elem|
	tag = Tag.new()
	tag.id = elem["id"]
	tag.name = elem["tag"]
	tag.save
end

json = JSON.parse(File.read("#{Rails.root}/db/chirpy_quote_tag.json"))
json.each do |elem|
	quote = Quote.find(elem["quote_id"])
	tag = Tag.find(elem["tag_id"])
	quote.tags << tag
	quote.save
	tag.save
end