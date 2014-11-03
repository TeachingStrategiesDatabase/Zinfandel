class StrategiesController < ApplicationController

	def show

	end
	
	def new
		@strategy = Strategy.new
	end

	def create
		@strategy = Strategy.new(strategy_params)
		@strategy.created_at = Time.new
		@strategy.updated_at = Time.new
 
  		if @strategy.save
  			redirect_to ("/home")
  		else 
  			render ("new")
  		end
		#render plain: params[:strategy].inspect
		#redirect_to("/home")
	end

	def update

	end

	def destroy

	end

	private
		def strategy_params
			#params.require(:title,:department,:subject,:body).permit(:tech)
			params.require(:strategy).permit(:title,:body,:tech)
		end

end
