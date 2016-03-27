
def show_os()
	return RbConfig::CONFIG['host_os']
end

def show_adapted_path()
	if show_os().include?('linux') then
		#linux
		path = ENV['NOTICE_PATH']
	elsif show_os().include?('darwin') then
		#iOS
		path = "./"
	end
	return path
end

def connect_adapted_mysql()
	if show_os().include?('linux') then
		#linux
		client = Mysql.connect('localhost', 'glacier', nil, 'notice')
	elsif show_os().include?('darwin') then
		#OSX
		client = Mysql.connect('localhost', 'root', nil, 'notice')
	end
	return client
end






