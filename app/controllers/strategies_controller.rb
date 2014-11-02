class StrategiesController < ApplicationController



	def new

	end
    
    

	def create
        
    
    end
        
        
    def show
            
            @strategy= Strategy.find(params[:id])
            
    end
        
	def update
        @strategies=Strategy.all
        
	end

	def destroy

	end

end
