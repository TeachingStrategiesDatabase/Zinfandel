class User < ActiveRecord::Base
	has_many :strategies

	validates_presence_of :email
	validates :email, :with => { :format => /.+@.+\..+/

end
