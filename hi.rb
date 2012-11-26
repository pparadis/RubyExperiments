require 'sinatra'
require 'base64'
require 'haml'
require 'securerandom'

set :static, true
set :public_folder, '/uploads'

get '/' do
  haml :index
end

get '/uploads/:file' do |f|
	send_file 'uploads/' + f
end

post '/image' do
	hostUrl = 'http://' + request.host_with_port()
	filePath = 'uploads/' + params['imageName']+SecureRandom.uuid.gsub('-','') + ".png"
	File.open(filePath, "wb") do |f|
		f.write(Base64.decode64(params['imageData']))
	end
	return 'http://' + request.host_with_port() + '/' + filePath
end