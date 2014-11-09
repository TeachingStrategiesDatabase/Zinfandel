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
		@subjectList = Subject.getSubjectList()
		@departmentList = Department.getDepartmentList()
		@user = current_user

		@strategy = @user.strategies.new(strategy_params)
		@strategy.subject = numToName(@strategy.subject,@subjectList)
		@strategy.department = numToName(@strategy.department,@departmentList)

 		if @strategy.save
 			nextModelId = last_model_id()
 			addKeywords(nextModelId,@strategy.keywords)
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

	def numToName(intString,departmentList)
		if (intString==nil)
			return nil
		else
			theInt = intString.to_i-1
			theList = departmentList[theInt]
			returnVal = theList[0]
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
            params.require(:strategy).permit(:title, :body, :tech, :source,:department,:keywords)
        end
end
