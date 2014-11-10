class StrategiesController < ApplicationController

	PAGE_ENTRIES_DEFAULT = 20

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

		if params[:entry_number]
			cookies[:page_entries] = params[:entry_number]
		end
	
		entries_per_page = cookies[:page_entries].to_i || PAGE_ENTRIES_DEFAULT	
		@currentPage = Strategy.search(params[:department],params[:subject],params[:keywords],params[:title],params[:author], @page, entries_per_page)
		if @currentPage.size < entries_per_page
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
		@user = current_user
		@strategy = @user.strategies.new(strategy_params)
		@strategy.department = Department.find(params[:department].to_i).name
		@strategy.subject = Subject.find(params[:subject].to_i).name
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
	
	def entry_number

		@per_page = params[:per_page]
		@strategy = Strategy.all.paginate :per_page => @per_page
	end


end
