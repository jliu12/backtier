class UsersController < ApplicationController

	def index
		@user = User.new
	end

	def logout
		if @currUser
			reset_session
			render json: {status: 200, note: "Logout successful"}, status: 200 and return
		end
		render json: {status: 403, note: "Not logged in"}, status: 403 and return
	end

	def create
		parameters = user_params
		@user = User.new(parameters)

		@user.user_last_time = DateTime.now
		if @user.valid?
			if parameters[:password].blank? or parameters[:password_confirmation].blank?
				render json: {status: 403, note: "Registration Error"}, status: 403 and return
			else
				@user.save
				render json: {status: 200, note: "OK", user_id: @user.id}, status: 200 and return
			end
		else
			render json: {status: 403, note: "Registration Error"}, status: 403 and return
		end
	end

	def login
		parameters = user_params
		if (parameters[:user_name].blank? and parameters[:phone_number].blank?) or parameters[:password].blank?
			render json: {status: 403, note: "Fields empty"}, status: 403 and return
		elsif not parameters[:user_name].blank?
			@user = User.find_by_user_name(parameters[:user_name])
			note2 = "user not found by name"
		else
			@user = User.find_by_phone_number(parameters[:phone_number])
			note2 = "user not found by number"
		end

		if @user.nil?
			render json: {status: 403, note: "Login Invalid"}, status: 403 and return
		else
			if @user.password_valid?(parameters[:password])
				session[:user_id] = @user.id
				render json: {status:200, note: "OK", user: @user}, status:200 and return
			else
				render json: {status: 403, note: "Password Invalid"}, status: 403 and return
			end
		end

	end

	def update_location
		parameters = user_params

		if @currUser.nil? 
			user_to_update = User.find_by_id(parameters[:id])
			if user_to_update.nil?
				render json: {status: 403, note: "Not logged in"}, status: 403 and return
			end
		else
			user_to_update = @currUser #User.find_by_id(parameters[:id])
		end
		
		user_to_update.user_last_lat = parameters[:user_last_lat]
		user_to_update.user_last_long = parameters[:user_last_long]
		user_to_update.user_last_time = DateTime.now

		user_to_update.save
		if user_to_update.valid?
			render json: {status: 200, note: "Location update successful"}, status: 200 and return
		else
			render json: {status: 403, note: "Update failed"}, status: 403 and return
		end
	end


	def update_info
		parameters = user_params
		user_to_update = User.find_by_id(parameters[:id])
		user_to_update.user_real_name = parameters[:user_real_name]
		user_to_update.phone_number = parameters[:phone_number]

		user_to_update.save
		if user_to_update.valid?
			render json: {status: 200, note: "Update successful"}, status: 200 and return
		else
			render json: {status: 403, note: "Update failed"}, status: 403 and return
		end
	end

	def user_params
		params.require(:user).permit(:id, :user_name, :user_real_name, :password, :password_confirmation, :user_last_lat, :user_last_long, :user_last_time, :phone_number)
	end

end

 