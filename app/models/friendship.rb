class Friendship < ActiveRecord::Base
	belongs_to :friender, :class_name => 'User', :foreign_key => 'friend1_id'
	belongs_to :friendee, :class_name => 'User', :foreign_key => 'friend2_id'
end
