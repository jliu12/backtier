class User < ActiveRecord::Base
	has_many :invitations
	has_many :participations
	has_many :events, :through => :participations
	has_many :messages
	has_many :friendships

	validates :user_name, :user_real_name, :presence => true
	validates :password, :confirmation => true
	validates :user_name_clean, :uniqueness => true
	validates :phone_number, :uniqueness => true

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
