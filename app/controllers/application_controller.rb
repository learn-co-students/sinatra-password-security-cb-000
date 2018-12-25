require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end

	post "/signup" do
		input = ["username", "password"]

		input.each do |data|
			if params[data.to_sym] == nil || params[data.to_sym].empty? || params[data.to_sym].match(/\s/) == true
				redirect to '/failure'
				break
			end
		end

		@user = User.create(username: params[:username], password: params[:password])
		session[:user_id] = @user.id

		redirect '/login'
	end

	get "/login" do
		erb :login
	end

	post "/login" do
		@user = User.find_by(username: params[:username], password: params[:password])

		if @user == nil
			redirect '/failure'
		else
			session[:user_id] = @user.id
			redirect '/success'
		end
	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
