class AddPassword < ActiveRecord::Migration
	def change
		add_column :users, :password_digest, :string
		add_column :users, :salt, :string
		User.reset_column_information
  		User.all.each { |user| 
  			user.password=user.login
  			user.save
  		}
	end
end
