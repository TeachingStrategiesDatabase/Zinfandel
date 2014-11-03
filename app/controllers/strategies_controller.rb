class StrategiesController < ApplicationController

	before_filter :logged_in, :only => [:new, :create, :update, :destroy]

	def show

	end
	
	def new
		@strategy = Strategy.new
	end

	def create
		@user = current_user
		@strategy = @user.strategies.new(strategy_params)
 
  		if @strategy.save
  			redirect_to ("/home")
  		else
				@errors = @strategy.errors 
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

		def logged_in
			current_user != nil
		end

end
