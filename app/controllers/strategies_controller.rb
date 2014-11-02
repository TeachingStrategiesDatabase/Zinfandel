class StrategiesController < ApplicationController


	
	def new

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
    
    
    def show
        
        @strategy = Strategy.find(params[:id])
        
    end

	def update

	end

	def destroy

	end

end
