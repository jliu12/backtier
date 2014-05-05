class EventsController < ApplicationController

	def index
		flash[:message] = "HUZZ2"
		@event = Event.new
	end

	# Must be formatted as: {'event': 
	#						{'event_name':'name', 
	#						'location': 'place', 'time': time}}
	def create
		parameters = event_params
		@event = Event.new(parameters)
		user = User.find_by_user_name(params[:user_name])
		@event.users << user
		@event.save

		if @event.valid?
			render json: {status: 200, note: "OK", event_id: @event.event_id}, status: 200
		else
			render json: {status: 403, note: "Event Creation Failed"}, status: 403
		end
	end


	def update
		parameters = event_params
		event_to_update = Event.find_by_id(parameters[:event_id])
		if event_to_update.update_attributes(parameters)
			event_to_update.save
			render json: {status: 200, note: "OK"}, status: 200
		else
			render json: {status: 403, note: "Event Update Failed"}, status: 403
		end
	end


	def event_params
		params.require(:event).permit(:event_id, :event_name, :latitude, :longitude, :location, :start_time, :end_time)
	end

end
    	