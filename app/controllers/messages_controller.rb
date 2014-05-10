class MessagesController < ApplicationController

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
		end
		if @message.valid?
			@message.save
			render json: {status: 200, note: "OK", message_id: @message.id, url: @message.photo_url}, status: 200 and return
		else
			render json: {status: 403, note: "Message Error"}, status: 403 and return
		end

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
		params.permit(:user_id, :date_time, :filename, :latitude, :longitude, :text, :ids => [])
	end
end	
