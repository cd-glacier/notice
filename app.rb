#encode utf-8
require "/projects/notice/pass.rb"
require "/projects/notice/notice.rb"
require "rubygems"
require "sinatra"
require "sinatra/base"
require "sinatra/reloader" if development?
require 'mysql'

class NoticeWeb < Sinatra::Base

	#e.g. <%= h hoge %>
	helpers do
		include Rack::Utils
		alias_method :h, :escape_html
	end


	before do
		#mysql
		@client= Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
		##client= Mysql.connect('localhost', 'root', nil, 'notice')
		stmt = @client.query('create table if not exists sites (
										keyword varchar(255),
										url varchar(255),
										email varchar(255),
										noticed bool
										)')
	end

	#########################################################################################

	get '/' do
		"Hello My First Web App!"
	end

	get '/notice' do
		erb :home
	end

	get '/delete' do
		erb :delete
	end

	post '/notice' do
		add_https(params[:url])

		stmt = @client.prepare("insert into sites values(?, ?, ?, false)")
		stmt.execute params[:keyword], params[:url], params[:email]

		redirect "/home"
	end

	post '/contact' do
		gmail("hyoga0216@gmail.com", params[:contact_email], params[:message])	
		redirect "/home"
	end

	get "delete/:email/:url" do

	end

end
