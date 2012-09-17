module Notifications
	def self.notify(title, message)
		require "net/https"

		url = URI.parse("https://api.pushover.net/1/messages.json")
		req = Net::HTTP::Post.new(url.path)
		req.set_form_data({
		  :token => "ggpNK0ie6fOYtmAoSeolMlD9v1Xwl6",
		  :user => "DyHtaI1fDOztmohoFQnc6Dyu4gRrmC",
		  :message => message,
		  :title => title,
		  :url => 'http://sse.se.rit.edu/qdb/admin',
		  :url_title => 'Admin Quotes'
		})
		res = Net::HTTP.new(url.host, url.port)
		res.use_ssl = true
		res.verify_mode = OpenSSL::SSL::VERIFY_PEER
		res.start {|http| http.request(req) }
	end
end