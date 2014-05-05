class Event < ActiveRecord::Base
	attr_accessible :event_name, :location, :time
	has_many :messages
	has_and_belongs_to_many :users
	has_many :invitations
end
