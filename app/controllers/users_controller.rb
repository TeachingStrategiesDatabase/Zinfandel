class UsersController < ApplicationController

	def new

	end

	def create
# check to see that confirm_password == password before continuing
	@user = User.new(user_info_params)
	@user.save
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
