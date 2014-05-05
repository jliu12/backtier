class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :event_name
    	t.string :location
    	t.decimal :latitude
    	t.decimal :longitude
    	t.datetime :start_time
    	t.datetime :end_time
      t.timestamps
    end
  end
end
