#encode utf-8
require '/projects/notice/adapt_ADE.rb'
#require './adapt_ADE.rb'
path = show_adapted_path()
require path + "pass.rb"
require path + "notice.rb"
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
		@client = connect_adapted_mysql()
		#@client = Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
		#@client = Mysql.connect('localhost', 'root', nil, 'notice')
		stmt = @client.query('create table if not exists sites (
													id int not null auto_increment,
													keyword varchar(255) not null,
													url varchar(255) not null,
													email varchar(255) not null,
													noticed bool not null,
													primary key(id)
													)')
	end

#########################################################################################

	get "/" do
		erb :home
	end

	get '/notice' do
		erb :home
	end

	get '/config' do
		erb :config_start
	end
		
	get '/config/:email' do
		client = connect_adapted_mysql()

		@adress = params[:email]
		@id = []
		@s_url = []
		@url = []
		@noticed = []
		@word = []
		@checkbox = []
		client.query("select noticed, url, keyword, id from sites where email = '" + params[:email] + "\'").each do |noticed, url, word, id|
			@id << id
			@noticed << noticed
			@s_url << shorten_string(url)
			@url << url
			@word <<  shorten_string(word)
			if noticed.to_i == 0 then 
				@checkbox << "checked = 'checked'"
			else 
				@checkbox	<< nil
			end

		end

		erb :config
	end

	post '/notice' do
		url = add_https(params[:url])

		insert_url(url, params[:keyword], params[:email])

		redirect "/notice"
	end

	post '/contact' do
		gmail("hyoga0216@gmail.com", params[:contact_email], params[:message])	
		redirect "/notice"
	end

	post '/sys' do
		puts params[:email]
		#if params[:email].nil? then
		#	redirect "/config"
		#else
			redirect "/config/" + params[:email].to_s
		#end
	end

=begin
	delete  "/config/:email/:url/:keyword" do
		delete_url(params[:url], params[:keyword], params[:email])	

		redirect "/notice"
	end
=end

	post '/config' do
		#postでdeleteってどうなんや？？
		#delete
		unless params[:delete_box].nil? then
			params[:delete_box].each do |id|
				delete_url(id)
			end
		end

		#update
		params[:notice_box].length.times do |i|
			if params[:notice_box][i].to_i == 0 then
				set_noticed_0(params[:notice_box_id][i].to_i)
			elsif params[:notice_box][i].to_i == 1 then
				set_noticed_1(params[:notice_box_id][i].to_i)
			else
				puts "update error"
			end	
		end

		redirect "/config/" + params[:email]
	end

end
