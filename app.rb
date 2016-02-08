#encode utf-8
require "sinatra"
require "sinatra/reloader" if development?

require 'active_record'

require 'nokogiri'
require 'open-uri'

require 'json'

require 'mail'

=begin
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

class Memos < ActiveRecord::Base
end
=end

#########################################################################################

get '/test' do
	@result = []

	#検索ワード＆検索ページ
	search_word = '22話'
	#uri
	url = "http://urasunday.com/bloodbone/index.html" 

	#mail通知
	mail = Mail.new do
		from "hyoga0216@gmail.com"
		to "hyoga0216@gmal.com"
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
				mail.delivery_method(:smtp,
					address:        "localhost",
					port:           4567,
					domain:         "localhost.localdomain",
					authentication: nil,
					user_name:      nil,
					password:       nil
				)
				mail.deliver
				@result = true
			end
		end
	end

	erb :test
end

get '/home' do

	erb :home
end

