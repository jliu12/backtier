class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
    	t.integer :event_id
    	t.integer :user_sent
    	t.integer :user_invited
      t.timestamps
    end

    create_table :users_invitations, :id => false do |t|
	   t.references :user, :invitation
	 end

    add_index :users_invitations, [:user_id, :invitation_id]
  end
end
