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
		@message.longitude = parameters[:longitude]]
		@message.event_id = parameters[:event_id]
		@message.user_id = parameters[:user_id]

		@message.event = Event.find_by_id(params[:messages][:event_id])
		@message.user = User.find_by_id(params[:messages][:user_id])
		
		if !params[:messages][:filename].nil?
			uploaded_photo = params[:messages][:filename]
			name = uploaded_photo.original_filename + @message.date_time.to_s.gsub(/\W+/,"")
			url = File.join('public/images', name)
			File.open(url, 'wb') do |file|
				file.write(uploaded_photo.read)
			end
			@message.photo_url = url
		end
		if @message.valid?
			@message.save
		end
		render json: {status: 200, note: ‘OK’, message_id: @message.id url: @message.photo_url}, status: 200

	end


	def message_params
		params.require(:message).permit(:user_id, :date_time, :filename, :latitude, :longitude, :text)
	end
end	
