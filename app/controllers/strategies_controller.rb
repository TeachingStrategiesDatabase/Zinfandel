class StrategiesController < ApplicationController

	PAGE_ENTRIES_DEFAULT = 20

	before_filter :logged_in, :only => [:new, :create, :edit, :update, :destroy]
	before_filter :user_owns_strategy, :only => [:edit, :update, :destroy]

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
#keywordList = keywords.split(/(?:,|\s)+/)
		@dep = @dep.split(/(?:,|\s)+/) if @dep.class == String
		@sub = @sub.split(/(?:,|\s)+/) if @sub.class == String

		if params[:entry_number]
			cookies[:page_entries] = params[:entry_number]
		end
	
		entries_per_page = !cookies[:page_entries].blank? ? cookies[:page_entries].to_i : PAGE_ENTRIES_DEFAULT	
		@currentPage = Strategy.search(@dep,@sub,params[:keywords],params[:title],params[:author], @page, entries_per_page)

		if @currentPage.size < entries_per_page
			@notLastPage = false
		else
			@notLastPage = true
		end
	end

	def new
		@departmentList = Department.departmentsForSelect
		@subjectList = Subject.subjectsForSelect

		@strategy = Strategy.new
	end
    
	def index
      
	end
    
# previous implementation of create
	def create
		@subjectList = Subject.getSubjectList()
		@departmentList = Department.getDepartmentList()
		@user = current_user

		@strategy = @user.strategies.new(strategy_params)

		@strategy.department = Department.find(params[:department].to_i).name

		@strategy.subject = Subject.find(params[:subject].to_i).name

#need to change department and subject from integer to string


 		if @strategy.save
 			nextModelId = last_model_id()
 			addKeywords(@strategy.id, params[:keywords])
			flash[:success] = "Strategy created successfully!"
  			redirect_to root_path
  		else
			@errors = @strategy.errors.full_messages
  			render "new"
  		end
	end

    def edit
        @strategy = Strategy.find(params[:id])

		@departmentList = Department.getDepartmentList
		@departmentId = Department.find_by_name(@strategy.department).id
		@subjectList = Subject.getSubjectList
		@subjectId = Subject.find_by_name(@strategy.subject).id
    end
    
	def update
        @strategy = Strategy.find(params[:id])
        
        if (@strategy.update(strategy_params) && @strategy.setKeywords(params[:keywords]) )
			flash[:success] = "Strategy updated successfully!"
            redirect_to root_path
        else
			@errors = @strategy.errors.full_messages
            render 'edit'
        end
        
    end
        
	def destroy
        
       		@strategy = Strategy.find(params[:id])
        	if( @strategy.destroy && @strategy.setKeywords(''))
				flash[:success] = "Strategy deleted successfully!"
		#do nothing
		else
			@errors = @strategy.errors
        	end

			if params[:from_show_view]
				redirect_to root_path
			else
        		redirect_to :action => "search", :department=> params[:department], :subject => params[:subject], :keywords => params[:keywords], :title => params[:title], :author => params[:author], :page => params[:page]
			end
		
	end

	def addKeywords(strategyId,keywords)
		keywordList = keywords.split(/(?:,|\s)+/)
		for keyword in keywordList
  			@keyword = Keyword.new()
  			@keyword.keyword = keyword
  			@keyword.strategy_id = strategyId
  			@keyword.save
		end
	end

	def last_model_id
    	lastModelList=ActiveRecord::Base.connection.execute('SELECT last_insert_rowid() as last_insert_rowid')
    	lastModelHash = lastModelList[0]
    	lastModelId = lastModelHash["last_insert_rowid"]
    	lastModelId.to_i
	end

	private
        def strategy_params
			params[:strategy][:department] = Department.find(params[:department].to_i).name
			params[:strategy][:subject] = Subject.find(params[:subject].to_i).name
            params.require(:strategy).permit(:title, :body, :tech, :source, :department, :subject)
        end

	
	def entry_number

		@per_page = params[:per_page]
		@strategy = Strategy.all.paginate :per_page => @per_page
	end


end
