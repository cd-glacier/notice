# encoding: utf-8
#require "./adapt_ADE.rb"
require "/projects/notice/adapt_ADE.rb"
path = show_adapted_path()
require 'clockwork'
require path + 'notice.rb'
require path + 'app.rb'
require 'mysql'

include Clockwork

@sites_table = "sites2"

every(10.minutes, 'work')  do
	#urlとsearch_word, mail adressをmysqlからとってくる
	#client = Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
	@client = connect_adapted_mysql()

	@client.query("select id, noticed, url, keyword, email, num from " + @sites_table).each do |id, noticed, url, word, mail_adress, num|
		if noticed[0].to_i == 0 then
			puts "seeking in " + url, word, mail_adress
			begin
				#通知
				notice(id, url, word, mail_adress, num)
			rescue => e
				set_noticed_e(id, @sites_table)
				puts e.message
=begin
				content = "エラーが発生したっぽい \n\n" + e.message
				gmail("hyoga0216@gmail.com", "notice", content)
=end
				next
			ensure
				puts " "
			end
		end
	end

	puts "work end"
end






