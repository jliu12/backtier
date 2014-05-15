class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.integer :user_id
    	t.integer :event_id
    	t.datetime :date_time
    	t.string :photo_url
    	t.decimal :latitude
    	t.decimal :longitude
      t.timestamps
    end
  end
end
