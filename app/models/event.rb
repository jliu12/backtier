class Event < ActiveRecord::Base
	default_scope order('created_at DESC')
	
	has_many :messages
	has_many :participations
	has_many :users, :through => :participations
	has_many :invitations
end
