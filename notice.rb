require './pass.rb'
require 'active_record'

require 'nokogiri'
require 'open-uri'

require 'json'

require 'mail'

#########################################################################################

def notice(url, search_word)
	#検索ワード＆検索ページ
	#search_word = '22話'
	#url = "http://urasunday.com/bloodbone/index.html" 

	#mail通知
	Mail.defaults do
		delivery_method :smtp, {
			:address => "smtp.gmail.com",
			:port => 587,
			:domain => 'gmail.com',
			:user_name => 'hyoga0216@gmail.com',
			:password => @pass,
			:authentication => 'plain',
			:enable_starttls_auto => true
		}
	end
	mail = Mail.new do
		from "hyoga0216@gmail.com"
		to "hyoga0216@gmail.com"
		subject "notice web"
		body "銀狼ブラッドボーン22話が更新されました！"
	end

	#更新されていたら通知する
	#doc = Nokogiri::HTML.parse(open(url, "r:Shift_JIS").read)
	doc = Nokogiri::HTML(open(url))
	doc.css('a, p').each do |node|
		node.each do |f|
			if node.text.include?(search_word) then
				#メール通知
				mail.charset = "UTF-8"
				mail.content_transfer_encoding = "8bit"
				mail.deliver
				@result = true
			end
		end
	end

end
