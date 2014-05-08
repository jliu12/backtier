class LoadData < ActiveRecord::Migration
  def up
  	down
  	u1 = User.new(:user_name => "jliu12", :user_real_name => "Jess Liu", :phone_number => "6266075549", :user_last_lat => 44.3, :user_last_long => 80.5)
  	u1.save(:validate => false)
  	u2 = User.new(:user_name => "skipper", :user_real_name => "Sam Watson", :phone_number => "6264515911", :user_last_lat => 44.2, :user_last_long => 99.3)
  	u2.save(:validate => false)
  	u3 = User.new(:user_name => "moonmip12", :user_real_name => "Chipper Whipper", :phone_number => "6262154681", :user_last_lat => 77.4, :user_last_long => 21.5)
  	u3.save(:validate => false)

  	e1 = Event.new(:user_id => 2, :event_name => "TCS Night Market", :location => "White Plaza", :latitude => "33.3", :longitude => "55.5", :start_time => "2014-05-19T18:00:00.000Z", :end_time => "2014-05-19T21:00:00.000Z")
  	e1.save(:validate => false)
  	e2 = Event.new(:user_id => 2, :event_name => "Dinner with Mom", :location => "NOLA's", :latitude => "77.7", :longitude => "64.5", :start_time => "2014-05-19T11:00:00.000Z", :end_time => "2014-05-19T14:00:00.000Z")
 	e2.save(:validate => false)

  	i1 = Invitation.new(:event_id => 1, :user_sent => 2, :user_invited => 1)
  	i1.save(:validate => false)
  	i2 = Invitation.new(:event_id => 1, :user_sent => 2, :user_invited => 3)
  	i2.save(:validate => false)
  end

  def down
  	User.delete_all
  	Event.delete_all
  	Invitation.delete_all
  end

end
