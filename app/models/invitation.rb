class Invitation < ActiveRecord::Base
	default_scope order('created_at DESC')
	belongs_to :user
	belongs_to :event
end
