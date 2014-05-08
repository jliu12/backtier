class LoadData < ActiveRecord::Migration
  def up
    down
    u1 = User.new(:user_name => "Jessica", :user_name_clean => "jessica", :user_real_name => "Jessica L", :phone_number => "6264444444", :user_last_lat => 37.425917, :user_last_long => -122.167432, :user_last_time => "2014-05-13 17:52",:password => "password")
    u1.save(:validate => true)
    u2 = User.new(:user_name => "Angela", :user_name_clean => "angela", :user_real_name => "Angela Y", :phone_number => "6265555555", :user_last_lat => 37.421716, :user_last_long => -122.147819, :user_last_time => "2014-05-13 17:40", :password => "password")
    u2.save(:validate => true)
    u3 = User.new(:user_name => "Alex", :user_name_clean => "alex", :user_real_name => "Alex W", :phone_number => "6267777777", :user_last_lat => 37.429240, :user_last_long => -122.173665, :user_last_time => "2014-05-13 17:55", :password => "password")
    u3.save(:validate => true)

    e1 = Event.new(:user_id => 2, :event_name => "Jason's Birthday Dinner", :location => "NOLA Restaurant & Bar", :latitude => 37.445107, :longitude => -122.161396, :start_time => "2014-05-13 18:00", :end_time => "2014-05-13 20:30")
    e1.users << u1
    e1.users << u2
    e1.users << u3
    e1.save

  end

  def down
    User.delete_all
    Event.delete_all
    Invitation.delete_all
  end

end
