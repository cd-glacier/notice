#encode utf-8
#require '/projects/notice/adapt_ADE.rb'
require './adapt_ADE.rb'
path = show_adapted_path()
require path + "pass.rb"
require path + "notice.rb"
require "rubygems"
require "sinatra"
require "sinatra/base"
require "sinatra/reloader" if development?
require 'mysql'

#class NoticeWeb < Sinatra::Base

	#e.g. <%= h hoge %>
	helpers do
		include Rack::Utils
		alias_method :h, :escape_html
	end

	before do
		#mysql
		@client = connect_adapted_mysql()
		#@client = Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
		#@client = Mysql.connect('localhost', 'root', nil, 'notice')
		stmt = @client.query('create table if not exists sites (
										keyword varchar(255),
										url varchar(255),
										email varchar(255),
										noticed bool
										)')
	end

#########################################################################################

	get "/" do
		erb :home
	end

	get '/notice' do
		erb :home
	end

	get '/config/:email' do
		client = connect_adapted_mysql()

		@adress = params[:email]
		@url = []
		@noticed = []
		@word = []
		@checkbox = []
		client.query("select noticed, url, keyword from sites where email = '" + params[:email] + "\'").each do |noticed, url, word|
			@noticed << noticed
			@url << url
			@word <<  word
			if noticed.to_i == 1 then 
				@checkbox << "checked = 'checked'"
			else 
				@checkbox	<< nil
			end

		end

		erb :config
	end

	post '/notice' do
		url = add_https(params[:url])

		insert_url(params[:keyword], url, params[:email])

		redirect "/notice"
	end

	post '/contact' do
		gmail("hyoga0216@gmail.com", params[:contact_email], params[:message])	
		redirect "/notice"
	end

	delete  "/config/:email/:url/:keyword" do
		delete_url(params[:url], params[:keyword], params[:email])	

		redirect "/notice"
	end

#end
