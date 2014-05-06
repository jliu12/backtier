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
				render json: {status:200, note: "OK", user: _user_obj(@user)}, status:200 and return
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

		if @currUser.nil? 
			user_to_update = User.find_by_id(parameters[:id])
			if user_to_update.nil?
				render json: {status: 403, note: "Not logged in"}, status: 403 and return
			end
		else
			user_to_update = @currUser #User.find_by_id(parameters[:id])
		end

		user_to_update = _update_fields(user_to_update, parameters)

		if user_to_update.valid?
			render json: {status: 200, note: "Update successful"}, status: 200 and return
		else
			render json: {status: 403, note: "Update failed"}, status: 403 and return
		end
	end

	def _update_fields(user_to_update, parameters)
		if parameters.has_key?(:user_real_name) and not parameters[:user_real_name].nil?
			user_to_update.update_column(:user_real_name, parameters[:user_real_name])
		end
		if parameters.has_key?(:user_name) and not parameters[:user_name].nil?
			user_to_update.update_column(:user_name, parameters[:user_name])

		end
		if parameters.has_key?(:phone_number) and not parameters[:phone_number].nil?
			user_to_update.update_column(:phone_number, parameters[:phone_number])
		end
		user_to_update.save
		return user_to_update	
	end

	def _user_obj(user)
		user_hash = Hash.new
		user_hash[:id] = user.id
		user_hash[:user_name] = user.user_name
		user_hash[:phone_number] = user.phone_number
		user_hash[:user_last_long] = user.user_last_long
		user_hash[:user_last_lat] = user.user_last_lat
		user_hash[:user_last_time] = user.user_last_time
		user_hash[:events] = user.events.pluck(:id)
		return user_hash

	end

	def get_user
		parameters = user_params
		user = User.find_by_id(parameters[:id])
		if not user.nil?
			render json: {status: 200, user: _user_obj(user)}, status: 200 and return
		else
			render json: {is_user: false}, status: 403 and return
		end
	end

	def is_user
		parameters = user_params
		if not parameters[:user_name].blank?
			user = User.find_by_id(parameters[:user_name])
		else 
			user = User.find_by_phone_number(parameters[:phone_number])
		end

		if not user.nil?
			render json: {is_user: true}, status: 200 and return
		else
			render json: {status: 403, note: "User does not exist", is_user: false}, status: 403 and return
		end
	end


	def user_params
		params.require(:user).permit(:id, :user_name, :user_real_name, :password, :password_confirmation, :user_last_lat, :user_last_long, :user_last_time, :phone_number)
	end

end

 