class StrategiesController < ApplicationController

   

	def new
        @strategy = Strategy.new
	end
    
    def index
        
    end
    

	def create
      render plain: params[:strategy].inspect
    end
        
        
    def show
         @strategies=Strategy.all   
            
            
    end
        
	def update
        
        @strategy= Strategy.find(params[:id])
	end

	def destroy
        
        @strategy = Strategy.find(params[:id])
        @strategy.destroy
        redirect_to :action => 'show'
	end

end
