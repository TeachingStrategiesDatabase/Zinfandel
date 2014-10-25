class User < ActiveRecord::Base
	has_many :strategies

	validates_presence_of :email, :true
	validates :email, :with => { :format => /.+@.+\..+/ }

end
