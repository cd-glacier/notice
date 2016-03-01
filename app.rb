#encode utf-8
require "./pass.rb"
require "./notice.rb"
require "rubygems"
require "sinatra"
require "sinatra/base"
require "sinatra/reloader" if development?


require 'mysql'

class NoticeWeb < Sinatra::Base

	#mysql
	client= Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
	stmt = client.query('create table if not exists sites (
										keyword varchar(255),
										url varchar(255),
										email varchar(255)
										)')

#########################################################################################

	get '/' do
		"Hello My First Web App!"
	end

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
		redirect "/home"
	end

	get "delete/:email/:url" do
			
	end

end
