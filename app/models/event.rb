class Event < ActiveRecord::Base
	has_many :messages
	has_many :participations
	has_many :users, :through => :participations
	has_many :invitations
	has_many :photos
end
