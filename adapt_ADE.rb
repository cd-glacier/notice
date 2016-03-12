#require "./pass.rb"
require "/projects/notice/pass.rb"

def show_os()
	return RbConfig::CONFIG['host_os']
end

def show_adapted_path()
	if show_os().include?('linux') then
		#linux
		path = PATH
	elsif show_os().include?('darwin') then
		#iOS
		path = "./"
	end
	return path
end

def connect_adapted_mysql()
	if show_os().include?('linux') then
		#linux
		client = Mysql.connect('localhost', 'root', MYSQL_PASS, 'notice')
	elsif show_os().include?('darwin') then
		#iOS
		client = Mysql.connect('localhost', 'root', nil, 'notice')
	end
	return client
end






