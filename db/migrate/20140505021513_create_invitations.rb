class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
    	t.integer :event_id
    	t.integer :user_sent
    	t.integer :user_invited
      t.timestamps
    end
  end
end
