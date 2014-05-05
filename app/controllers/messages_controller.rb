class MessagesController < ApplicationController

	def create
		@message = Message.new
		@message.date_time = DateTime.now
		@message.text = params[:messages][:text]
		@message.location_lat = params[:messages][:location_lat]
		@message.location_long = params[:messages][:location_long]
		@message.event_id = params[:messages][:event_id]
		@message.user_id = params[:messages][:user_id]

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

		if @message.valid?
			@message.save

		render json: {status: 200, note: ‘OK’, url: @message.photo_url}, status: 200

	end

end