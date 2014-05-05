class UsersController < ApplicationController

	def index
		flash[:message] = "HUZZ2"
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		#Take this out later.. 
		@user.user_last_time = DateTime.now
		if @user.valid?
			if params[:user][:password].blank? or params[:user][:password_confirmation].blank?
				render json: {status: 403, note: "Password and Confirmation can't be blank"}, status: 403 and return
			else
				@user.save
				flash[:success] = "SUCCESS"
				render json: {status: 200, note: "OK"}, status: 200 and return
			end
		else
			render json: {status: 403, note: "Password and Confirmation can't be blank"}, status: 403 and return
		end
	end


	def update_location
		parameters = user_params

		user_to_update = User.find_by_user_name(parameters[:user_name])
		user_to_update.user_last_lat = parameters[:user_last_lat]
		user_to_update.user_last_long = parameters[:user_last_long]
		user_to_update.user_last_time = DateTime.now

		user_to_update.save
		if user_to_update.valid?
			render json: {status: 200, note: "Update successful"}, status: 200 and return
		else
			render json: {status: 403, note: "Update failed"}, status: 403 and return
		end
	end


	def update_info
		parameters = user_params
		user_to_update = User.find_by_user_name(parameters[:user_name])
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
		params.require(:user).permit(:user_name, :user_real_name, :password, :password_confirmation, :user_last_lat, :user_last_long, :user_last_time, :phone_number)
	end

end

 