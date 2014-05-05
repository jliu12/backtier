class Event < ActiveRecord::Base
	has_many :messages
	has_and_belongs_to_many :users
	has_many :invitations
end
