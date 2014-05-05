class User < ActiveRecord::Base
	has_many :invitations
	has_and_belongs_to_many :events
	has_many :messages
	has_many :friendships

	validates :user_name, :user_real_name, :presence => true
	validates :password, :confirmation => true
	validates :user_name, :uniqueness => true

	def password=(arg)
 		@password = arg
 		self.salt = SecureRandom.urlsafe_base64
 		self.password_digest = generate_digest(@password, self.salt)
	end

	def password
		@password
	end

	def generate_digest(password, salt)
		hash = password.to_s + salt.to_s
		Digest::SHA1.hexdigest (hash)
	end

	def password_valid?(password)
		hash = generate_digest(password, self.salt)
		return hash.eql?(self.password_digest)
	end

end
