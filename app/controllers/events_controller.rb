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

		if @currUser.nil? 
			user = User.find_by_id(parameters[:user_id])
		else
			user = @currUser 
		end

		@event.users << user
		@event.save


		if @event.valid?
			render json: {status: 200, note: "OK", event_id: @event.id}, status: 200 and return
		else
			render json: {status: 403, note: "Event Creation Failed"}, status: 403 and return 
		end
	end


	def update
		parameters = event_params
		event_to_update = Event.find_by_id(parameters[:id])

		_update_fields(event_to_update, parameters)

		if event_to_update.valid?
			render json: {status: 200, note: "OK"}, status: 200 and return 
		else
			render json: {status: 403, note: "Event Update Failed"}, status: 403 and return 
		end
	end


	def _update_fields(event_to_update, parameters)
		if parameters.has_key?(:event_name) and not parameters[:event_name].nil?
			event_to_update.update_column(:event_name, parameters[:event_name])
		end
		if parameters.has_key?(:start_time) and not parameters[:start_time].nil?
			event_to_update.update_column(:start_time, parameters[:start_time])
		end
		if parameters.has_key?(:end_time) and not parameters[:end_time].nil?
			event_to_update.update_column(:end_time, parameters[:end_time])
		end
		if parameters.has_key?(:latitude) and not parameters[:latitude].nil?
			event_to_update.update_column(:latitude, parameters[:latitude])
		end
		if parameters.has_key?(:longitude) and not parameters[:longitude].nil?
			event_to_update.update_column(:longitude, parameters[:longitude])
		end
		if parameters.has_key?(:location) and not parameters[:location].nil?
			event_to_update.update_column(:location, parameters[:location])
		end

		event_to_update.save

		return event_to_update	
	end

	def event_params
		params.require(:event).permit(:id, :user_id, :event_name, :latitude, :longitude, :location, :start_time, 
			:end_time, :user_name, :notes, :min_id, :max_id, :count)
	end

	def _event_obj(event)
		event_hash = Hash.new
		event_hash[:id] = event.id
		event_hash[:user_id] = event.user_id
		event_hash[:event_name] = event.event_name
		event_hash[:location] = event.location
		event_hash[:latitude] = event.latitude
		event_hash[:longitude] = event.longitude
		event_hash[:start_time] = event.start_time
		event_hash[:end_time] = event.end_time
		event_hash[:notes] = event.notes
		event_hash[:users] = event.users.pluck(:id)
		event_hash[:messages] = event.messages.pluck(:id)
		return user_hash
	end

	def get_event
		parameters = event_params
		event = Event.find_by_id(parameters[:id])
		event_hash = _event_obj(event)
		render json: event_hash and return
	end

	def get_event_attendee_locations
		parameters = event_params
		event = Event.find_by_id(parameters[:id])
		attendees = event.users
		coord_hash = Hash.new
		coord_hash[:list] = Array.new
		'''attendees.each do |attendee|
			id = attendee.id
			coord_hash[id] = {:user_name => attendee.user_name,
							  :user_last_lat => attendee.user_last_lat, 
							  :user_last_long => attendee.user_last_long, 
							  :user_last_time => attendee.user_last_time}
		end'''
		attendees.each do |attendee|
			coord_hash[:list] << {:user_name => attendee.user_name,
							  	  :user_last_lat => attendee.user_last_lat, 
						 	   	  :user_last_long => attendee.user_last_long, 
							      :user_last_time => attendee.user_last_time}
		end
		render json: coord_hash and return
	end

	'''def get_event_messages
		parameters = event_params
		event = Event.find_by_id(parameters[:id])
		msg_hash = Hash.new
		if parameters.has_key?("max_id") and parameters.has_key?("min_id")
			if parameters.has_key("count")
				messages = Message.where("event_id").limit(parameters[:count]).order('created_at desc')
			else
				messages = Message.where("event_id").order('created_at desc')
			end
		elsif parameters.has_key?("max_id")
			if parameters.has_key("count")
				messages = Message.where("event_id").limit(parameters[:count]).order('created_at desc')
			else
				messages = Message.where("event_id").order('created_at desc')
			end
		elsif parameters.has_key?("min_id")
			if parameters.has_key("count")
				messages = Message.where("event_id").limit(parameters[:count]).order('created_at desc')
			else
				messages = Message.where("event_id = ? AND id").order('created_at desc')
			end
		elsif parameters.has_key?("count")
			messages = Message.where("event_id = ?", parameters[:id]).limit(parameters[:count]).order('created_at desc')
		else
			messages = Message.where("event_id = ?", parameters[:id]).order('created_at desc')
		end

		messages.each do |msg|
			msg_hash[msg.id] = _msg_object(msg)
		end
		render json: msg_hash and return
	end'''

end
    	