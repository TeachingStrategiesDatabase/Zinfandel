class StrategiesController < ApplicationController

	def show
        
        @strategy = Strategy.find(params[:id])

	end
	
	def new

	end

	def create
        
        @strategy = Strategy.new(strategy_params)
        
        @strategy.save
        redirect_to @strategy
    end
    
    private
    def strategy_params
        params.require(:strategy).permit(:title, :text, :body, :tech, :source)

	end

	def update

	end

	def destroy

	end

end
