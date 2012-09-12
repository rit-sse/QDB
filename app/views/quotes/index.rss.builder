xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "SSE QDB"
    xml.description "The quote database for the SSE"
    xml.link "https://sse.se.rit.edu/qdb"
    xml.image do
      xml.url "http://sse.se.rit.edu/qdb/assets/favicon.ico"
    end

    for quote in @quotes
      xml.item do
        xml.title quote.body
        xml.description quote.description
        xml.pubDate quote.created_at.to_s(:rfc822)
        xml.link "http://sse.se.rit.edu/qdb/quotes/#{quote.id}"
        xml.guid "http://sse.se.rit.edu/qdb/quotes/#{quote.id}"
      end
    end
  end
end