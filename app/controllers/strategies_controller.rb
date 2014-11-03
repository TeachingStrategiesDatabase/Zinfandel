class StrategiesController < ApplicationController

	before_filter :logged_in, :only => [:new, :create, :update, :destroy]

	def show
		@AStrategy = Strategy.find(params[:id])
	end
	
	def search
		@page = params[:page]
		@page = '1' if not @page

		@dep = params[:department]
		@sub = params[:subject]
		@kwd = params[:keywords]
		@tit = params[:title]
		@aut = params[:author]
		
		@currentPage = Strategy.search(params[:department],params[:subject],params[:keywords],params[:title],params[:author],@page)
		if @currentPage.size<2
			@notLastPage = false
		else
			@notLastPage = true
		end
	end

	def new
		@strategy = Strategy.new
	end
    
  def index
      
  end
    

	def create
		@user = current_user
		@strategy = @user.strategies.new(strategy_params)
 
  		if @strategy.save
  			redirect_to root_path
  		else
				@errors = @strategy.errors 
  			render "new"
  		end
	end

	def update
        #redirect_to :action => 'update'
        #@strategy= Strategy.find(params[:id])
        
	end

	def destroy
        
        @strategy = Strategy.find(params[:id])
        @strategy.destroy
        redirect_to :action => 'show'
	end

	private
		def strategy_params
			#params.require(:title,:department,:subject,:body).permit(:tech)
			params.require(:strategy).permit(:title,:body,:tech)
		end

		def logged_in
			redirect_to homepage_path, :notice => "You are not logged in." unless current_user
		end

end
