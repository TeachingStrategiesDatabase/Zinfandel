class UsersController < ApplicationController

	before_filter :logged_in, :except => [:new, :create]
	before_filter :user_is_admin, :only => [:admin, :admin_update_depts_subjects]

	def new
	end

	def create
# check to see that confirm_password == password before continuing
	  @user = User.new(user_info_params)
	  if !validate_password(params[:user][:password])
		  	@user.valid?
			@user.errors[:password] << 'must be at least six characters.'
			@errors = @user.errors.full_messages
			render 'new'
	  elsif params[:user][:confirm_password] != params[:user][:password]
			@user.valid?
		    @user.errors[:password] << 'and password confirmation must match.'
			@errors = @user.errors.full_messages
			render 'new'
	  else
			if @user.save
				@user.log_in
				cookies[:sid] = @user.session_token
				flash[:success] = "Account created successfully!"
				redirect_to root_path
			else
				@errors = @user.errors.full_messages
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
		@errors = params[:errors] if params[:errors]
	end

	def admin_update_depts_subjects
		@errors = []
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
		old_depts.each do |d| #for each department make sure that it is not in a current strategy before deleting
			current_department = Department.find_by_name(d)
			d_name = current_department.name
			if (Strategy.hasDepartment(d_name)==false)
				current_department.destroy
			else
				#Write out some sort of error message
				@errors.push("There are strategies in the database which have the " + d_name + " department.  
					Remove these strategies before deleting " + d_name + ".")
			end
		end
		old_subjects.each do |s| 
			current_subject = Subject.find_by_name(s)
			s_name = current_subject.name
			if (Strategy.hasSubject(s_name)==false)
				current_subject.destroy
			else
				#Write out some sort of error message
				@errors.push("There are strategies in the database which have the " + s_name + " subject.  
					Remove these strategies before deleting " + s_name + ".")
			end
		end

		if @errors.empty?
			flash[:success] = "Action completed successfully!" 
		else
			flash[:warning] = "Action completed with errors."
		end
		redirect_to :action => 'admin', :errors => @errors
	end

#=== Private methods =========================================================
	 private

   def user_info_params
	    params[:user][:name] = params[:user][:first_name] + ' ' + params[:user][:last_name]
   	   params.require(:user).permit(:name, :email, :password)
 	 end

	def validate_password(password)
		if password.blank? || (password.length < 6)
			false
		else
			true
		end
	end

end
