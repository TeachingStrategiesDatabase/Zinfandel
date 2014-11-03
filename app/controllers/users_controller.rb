class UsersController < ApplicationController

	def new
	end

	def create
# check to see that confirm_password == password before continuing
	  if params[:user][:confirm_password] != params[:user][:password]
#		@errors = @users.errors
			redirect_to :action => 'new'
	  else
			@user = User.new(user_info_params)
			@user.save
			redirect_to root_path
	  end
	end

	 private

   def user_info_params
	    params[:user][:name] = params[:user][:first_name] + ' ' + params[:user][:last_name]
   	   params.require(:user).permit(:name, :email, :password)
 	 end

	def update
	end

	def destroy
	end

end
