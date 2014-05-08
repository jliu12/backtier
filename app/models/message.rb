class Message < ActiveRecord::Base
	default_scope order('created_at DESC')
	belongs_to :event
	belongs_to :user
end
