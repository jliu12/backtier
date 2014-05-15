class MessagesController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	def index
		@message = Message.new
	end


	def create
		parameters = message_params
		@message = Message.new
		@message.date_time = DateTime.now
		@message.text = parameters[:text]
		@message.latitude = parameters[:latitude]
		@message.longitude = parameters[:longitude]
		@message.event_id = parameters[:event_id]
		@message.user_id = parameters[:user_id]

		@message.event = Event.find_by_id(params[:message][:event_id])
		@message.user = User.find_by_id(params[:message][:user_id])
		
		if !params[:message][:filename].nil?
			uploaded_photo = params[:message][:filename]
			name = uploaded_photo.original_filename + @message.date_time.to_s.gsub(/\W+/,"")
			url = File.join('public/images', name)
			File.open(url, 'wb') do |file|
				file.write(uploaded_photo.read)
			end
			@message.photo_url = url

			@photo_msg = @message.user.photo
			if not @photo_msg.nil?
				@photo_msg.destroy
			end
			@photo_msg = _create_photo_msg(@message)
			@photo_msg.user = @message.user
			@photo_msg.event = @message.event
			@photo_msg.save

		end
		if @message.valid?
			@message.save
			render json: {status: 200, note: "OK", message_id: @message.id, url: @message.photo_url, text: parameters[:text]}, status: 200 and return
		else
			render json: {status: 403, note: "Message Error"}, status: 403 and return
		end

	end

	def upload_photo
		@message = Message.new
		@message.date_time = DateTime.now
		@message.latitude = params[:latitude]
		@message.longitude = params[:longitude]
		@message.event_id = params[:event_id]
		@message.user_id = params[:user_id]

		@message.event = Event.find_by_id(params[:event_id])
		@message.user = User.find_by_id(params[:user_id])
		
		if !params[:filename].nil?
			uploaded_photo = params[:filename]
			name = uploaded_photo.original_filename + @message.date_time.to_s.gsub(/\W+/,"")
			url = File.open('public/images/' << name << '.jpg', 'wb') do |url|
				url.write(uploaded_photo.read)
			end
			@message.photo_url = 'public/images/' << name << '.jpg'

			@photo_msg = @message.user.photo
			if not @photo_msg.nil?
				@photo_msg.destroy
			end
			@photo_msg = _create_photo_msg(@message)
			@photo_msg.user = @message.user
			@photo_msg.event = @message.event
			@photo_msg.save

		end
		if @message.valid?
			@message.save
			render json: {status: 200, note: "OK", message_id: @message.id, url: @message.photo_url}, status: 200 and return
		else
			render json: {status: 403, note: "Message Error"}, status: 403 and return
		end

	end


	def _create_photo_msg(message)
		photo_msg = Photo.new
		photo_msg.date_time = @message.date_time
		photo_msg.latitude = @message.latitude
		photo_msg.longitude = @message.longitude
		photo_msg.event_id = @message.event_id
		photo_msg.user_id = @message.user_id
		photo_msg.photo_url = @message.photo_url
		photo_msg.save
		return photo_msg
	end


	def get_messages
		parameters = message_params
		msg_hash = Hash.new
		messages = Message.find(parameters[:ids]).group_by(&:id)
		render json: messages and return
	end

	def _msg_obj(msg)
		msg_hash = Hash.new
		msg_hash[:date_time] = msg.date_time
		msg_hash[:text] = msg.text
		msg_hash[:latitude] = msg.latitude
		msg_hash[:longitude] = msg.longitude
		msg_hash[:event_id] = msg.event_id
		msg_hash[:user_id] = msg.user_id
		msg_hash[:photo_url] = msg.photo_url
		return msg_hash
	end

	def message_params
		params.require(:message).permit(:user_id, :date_time, :filename, :latitude, :longitude, :text, :ids => [])
	end
end	
