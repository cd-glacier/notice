require './pass.rb'

require 'nokogiri'
require 'open-uri'

require 'mail'

require 'mysql'

#########################################################################################

#mail通知
def gmail(from_adress, content)
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
		to "hyoga0216@gmail.com"
		subject "notice web"
		body content
	end

	#メール通知
	mail.charset = "UTF-8"
	mail.content_transfer_encoding = "8bit"
	mail.deliver

end

def delete_url(email, url)
	stmt = client.prepare("delete from notice where email = ? and url = ?")
	stmt.execute email, url
end

#連番をどう処理しようかしら
def apdate_url(email, url)
	stmt = client.prepare("update notice set keyword = ? where email = ? and url = ?")
	stmt.execute next_word, email, url
end


def notice(url, search_word)
	#検索ワード＆検索ページ
	#search_word = '22話'
	#url = "http://urasunday.com/bloodbone/index.html" 


	#更新されていたら通知する
	#doc = Nokogiri::HTML.parse(open(url, "r:Shift_JIS").read)
	doc = Nokogiri::HTML(open(url))
	doc.css('a, p').each do |node|
		node.each do |f|
			if node.text.include?(search_word) then
				email("hyoga0216@gmail.com", "銀狼ブラッドボーンが更新されました！")
								
			end
		end
	end

end
