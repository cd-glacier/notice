require './pass.rb'

require 'nokogiri'
require 'open-uri'

require 'mail'
require 'mysql'

#########################################################################################

def gmail(to_adress, from_adress, content)
	Mail.defaults do
		delivery_method :smtp, {
			:address => "smtp.gmail.com",
			:port => 587,
			:domain => 'gmail.com',
			:user_name => 'hyoga0216@gmail.com',
			:password => PASS,
			:authentication => 'plain',
			:enable_starttls_auto => true
		}
	end
	mail = Mail.new do
		from from_adress
		to to_adress
		subject "notice web"
		body content = from_adress + "\n" + content
	end

	mail.charset = "UTF-8"
	mail.content_transfer_encoding = "8bit"
	mail.deliver

end

def delete_url(email, url)
	stmt = client.prepare("delete from notice where email = ? and url = ?")
	stmt.execute email, url
end

def apdate_url(email, url)
	stmt = client.prepare("update notice set keyword = ? where email = ? and url = ?")
	stmt.execute next_word, email, url
end


def notice(url, search_word, adress)
	stop_url = "stop_url"

	#search_word = '22話'
	#url = "http://urasunday.com/bloodbone/index.html" 

	#doc = Nokogiri::HTML.parse(open(url, "r:Shift_JIS").read)
	doc = Nokogiri::HTML(open(url))
	doc.css('a, p, h1, h2, h3').each do |node|
		node.each do |f|
			if node.text.include?(search_word) then
				content = search_word + " of " + url + "is up to date \n You can stop notice -> " + stop_url
				gmail(adress, "hyoga0216@gmail.com", content)
			end
		end
	end

end
