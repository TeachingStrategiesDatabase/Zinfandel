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
		@departmentList = Department.getDepartmentList()
		@subjectList = Subject.getSubjectList()

		@strategy = Strategy.new
	end
    
	def index
      
	end
    
# previous implementation of create
	def create
<<<<<<< HEAD
		@user = current_user
		@strategy = @user.strategies.new(strategy_params)
		@strategy.department = numToName(@departmentList,@strategy.department)
		@strategy.subject = numToName(@subjectList,@strategy.subject)
#need to change department and subject from integer to string
 		if @strategy.save
#need to add rows to keywords table
  			redirect_to root_path
  		else
			@errors = @strategy.errors 
  			render "new"
  		end
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
        
    end
        
	def destroy
        
        @strategy = Strategy.find(params[:id])
        @strategy.destroy
        redirect_to :action => 'show'
	end

	private
        def strategy_params
            params.require(:strategy).permit(:title, :body, :tech, :source)
        end
end
