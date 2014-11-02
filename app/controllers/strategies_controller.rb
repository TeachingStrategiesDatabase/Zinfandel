class StrategiesController < ApplicationController



	def new

	end
    
    def show
        
         @strategy = Strategy.find(params[:id])
         @strategies = Strategy.all
    end

	def create
        
        @strategy = Strategy.new(strategy_params)
        
        @strategy.save
        redirect_to @strategy
    end
    
    private
    def strategy_params
        params.require(:strategy).permit(:id, :title, :text, :body, :tech, :source)
        
	end
    

	def update
        
        
	end

	def destroy

	end

end
