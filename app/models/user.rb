require 'bcrypt'
class User < ActiveRecord::Base
	include BCrypt

	has_many :strategies

	#validates :email, :presence => true
	#validates :email, :with => { :format => /.+@.+\..+/ }

	def is_admin?
		self.admin
	end

<<<<<<< HEAD
<<<<<<< HEAD
	def is_author(strategy)
		self.id==strategy.user.id
	end

=======
>>>>>>> 7d80c0ea6d6fa46283329e6920986b444cdeb469
=======
	def is_author?(strategy)
		self.id == strategy.user.id
	end

>>>>>>> 8e6480efc5c7b13b22d56e1de2cd4884cbe7c383
	def log_in
		self.session_token = SecureRandom.base64
		self.save
	end

	def log_out
		self.session_token = nil
		self.save
	end

	def verify_password(given_password)
		Password.new(self.password_hash) == given_password
	end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
