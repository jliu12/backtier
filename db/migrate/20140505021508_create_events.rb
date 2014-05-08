class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.integer :user_id
    	t.string :event_name
    	t.string :location
    	t.decimal :latitude
    	t.decimal :longitude
    	t.datetime :start_time
    	t.datetime :end_time
      t.string :notes
      t.timestamps
	 end

	 create_table :users_events, :id => false do |t|
	   t.references :user, :event
	 end

	 add_index :users_events, [:user_id, :event_id]

  end
end
