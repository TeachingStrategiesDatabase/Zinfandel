class StrategiesController < ApplicationController


	
	def new

	end
    
    def show
        
    end

	def create
        
        @strategy = Strategy.new(params[:strategy])
        
        @strategy.save
        redirect_to @strategy
        
	end
    

	def update

	end

	def destroy

	end

end
