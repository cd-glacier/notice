# encoding: utf-8
require 'clockwork'
require '/projects/notice/notice.rb'
require '/projects/notice/app.rb'
require 'mysql'

include Clockwork

every(30.minutes, 'work')  do
	#urlとsearch_word, mail adressをmysqlからとってくる
	client= Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
	client.query("select noticed from sites").each do |noticed|
		if noticed[0].to_i == 0 then
			client.query("select url, keyword, email from sites").each do |url, word, mail_adress|
				#通知
				notice(url, word, mail_adress)
				#noticed をtrueにする
				stmt = client.prepare("update sites set noticed = 1 where url = ? && keyword = ? && email = ?")
				stmt.execute url, word, mail_adress
			end
		end
	end
end






