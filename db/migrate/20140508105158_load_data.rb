class LoadData < ActiveRecord::Migration
  def up
    down
    u1 = User.new(:user_name => "Jessica", :user_name_clean => "jessica", :user_real_name => "Jessica L", :phone_number => "6264444444", :user_last_lat => 44.3, :user_last_long => 80.5, :password => "password")
    u1.save(:validate => true)
    u2 = User.new(:user_name => "Angela", :user_name_clean => "angela", :user_real_name => "Angela Y", :phone_number => "6265555555", :user_last_lat => 44.2, :user_last_long => 99.3, :password => "password")
    u2.save(:validate => true)
    u3 = User.new(:user_name => "Alex", :user_name_clean => "alex", :user_real_name => "Alex W", :phone_number => "6267777777", :user_last_lat => 77.4, :user_last_long => 21.5, :password => "password")
    u3.save(:validate => true)
  end

  def down
    User.delete_all
    Event.delete_all
    Invitation.delete_all
  end

end
