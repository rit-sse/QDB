Quote.all.each do |quote|
  quote.body = quote.body.gsub("<%newline%>","\n")
  quote.save
end
