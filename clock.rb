require 'clockwork'
require './notice.rb'
require 'mysql'

module Clockwork

	handler do |job|
		puts "running"
	end

	def work
		#urlとsearch_wordをmysqlとってくる
		url = ""
		word = ""	
		notice(url, word)		
	end

	every(1.hour, 'work') 

end




