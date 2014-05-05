class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :user_name
    	t.string :user_real_name
    	t.string :phone_number
    	t.decimal :user_last_lat
    	t.decimal :user_last_long
    	t.datetime :user_last_time
      t.timestamps
    end
  end
end
