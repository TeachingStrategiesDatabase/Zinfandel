class UsersController < ApplicationController

	before_filter :logged_in, :except => [:new, :create]
	before_filter :user_is_admin, :only => [:admin, :admin_update_depts_subjects]

	def new
	end

	def create
# check to see that confirm_password == password before continuing
	  @user = User.new(user_info_params)
	  if params[:user][:confirm_password] != params[:user][:password]
			@user.valid?
		    @user.errors[:password] << ': Password and password confirmation must match.'
			@errors = @user.errors
			render 'new'
	  else
			if @user.save
				redirect_to root_path
			else
				@errors = @user.errors
				render 'new'
			end
	  end
	end

	def update
	end

	def destroy
	end

	def admin
		@departments = Department.all
		@subjects = Subject.all
		#@users = User.all
	end

	def admin_update_depts_subjects
		current_depts = Department.all.collect { |d| d.name }
		current_subjects = Subject.all.collect { |s| s.name }

		# add new values to the database
		new_depts = params[:departments].split(/,\s*/).reject { |d_name| current_depts.include?(d_name) }
		new_subjects = params[:subjects].split(/,\s*/).reject { |s_name| current_subjects.include?(s_name) }
		new_depts.each { |d_name| Department.new(:name => d_name).save }
		new_subjects.each { |s_name| Subject.new(:name => s_name).save }

		# remove old values from the database
		old_depts = current_depts.reject { |d| params[:departments].split(/,\s*/).include?(d) }
		old_subjects = current_subjects.reject { |s| params[:subjects].split(/,\s*/).include?(s) }
		old_depts.each { |d| Department.find_by_name(d).destroy }
		old_subjects.each { |s| Subject.find_by_name(s).destroy }

		redirect_to admin_path
	end

#=== Private methods =========================================================
	 private

   def user_info_params
	    params[:user][:name] = params[:user][:first_name] + ' ' + params[:user][:last_name]
   	   params.require(:user).permit(:name, :email, :password)
 	 end

end
