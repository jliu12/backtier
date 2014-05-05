class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :event_name
    	t.string :location
    	t.datetime :time
      t.timestamps
    end
  end
end
