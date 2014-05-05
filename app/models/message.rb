class Message < ActiveRecord::Base
	attr_accessible :date_time, :photo_url, :location_lat, :location_long, :text
	belongs_to :event
	belongs_to :user
end
