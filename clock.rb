# encoding: utf-8
require 'clockwork'
require '/projects/notice/notice.rb'
require '/projects/notice/app.rb'
require 'mysql'

include Clockwork

every(30.minutes, 'work')  do
	#urlとsearch_word, mail adressをmysqlからとってくる
	client = Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
	client.query("select noticed, url, keyword, email from sites").each do |noticed, url, word, mail_adress|
		if noticed[0].to_i == 0 then
			puts "seeking in " + url, word, mail_adress
			#通知
			notice(url, word, mail_adress)
			puts " "
		end
	end
end






