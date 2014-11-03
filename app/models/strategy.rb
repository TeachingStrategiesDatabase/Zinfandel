class Strategy < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true,
                    length: { minimum: 3 }
    #validates :subject, presence: true,
                    #length: { minimum: 3 }
    #validates :department, presence: true,
                    #length: { minimum: 3 }
    validates :body, presence: true,
                    length: { minimum: 10 }

end
