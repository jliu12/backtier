class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_id
    	t.integer :event_id
    	t.datetime :date_time
    	t.string :photo_url
    	t.string :text
    	t.decimal :location_lat
    	t.decimal :location_long
      t.timestamps
    end
    create_table :events_messages, :id => false do |t|
      t.references :event, :message
   end

    add_index :events_messages, [:event_id, :message_id]
  end
end
