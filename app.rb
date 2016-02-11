#encode utf-8
require "./notice.rb"
require "rubygems"
require "sinatra"
require "sinatra/reloader" if development?

require 'mysql'

require 'nokogiri'
require 'open-uri'

require 'json'

require 'mail'

#mysql
client= Mysql.connect('localhost', 'root', nil, 'notice')
stmt = client.query('create table if not exists sites (
										keyword varchar(255),
										url varchar(255),
										email varchar(255)
										)')


#########################################################################################

get '/home' do
	erb :home
end

post '/notice' do
	stmt = client.prepare("insert into sites values(?, ?, ?)")
	stmt.execute params[:keyword], params[:url], params[:email]
	
	redirect "/home"	
end

post '/contact' do
	gmail(params[:contact_email], params[:message])	
end
