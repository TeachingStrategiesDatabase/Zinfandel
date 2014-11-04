class StrategiesController < ApplicationController

   

	def new
        @strategy = Strategy.new
	end
    
    def index
        
    end
    

	def create
        render plain: params[:strategy].inspect
        #Strategy.create(strategy_params)
    end
        
        
    def show
         @strategies=Strategy.all   
            
            
    end
    
    def edit
        @strategy = Strategy.find(params[:id])
    end
    
    
	def update
        @strategy = Strategy.find(params[:id])
        
        if @strategy.update(strategy_params)
            redirect_to @strategy
        else
            render 'edit'
        end
        
        #private
        def strategy_params
            params.require(:strategy).permit(:title, :body, :tech, :source)
        end
    end
        
        
        def strategy_params
            params.require(:strategy).permit(:title, :body, :tech, :source)
        end
    
    
    

	def destroy
        
        @strategy = Strategy.find(params[:id])
        @strategy.destroy
        redirect_to :action => 'show'
	end

end
