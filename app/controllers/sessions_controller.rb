class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:email])
		@errors = []

		if not params[:password].blank?
			if user && user.verify_password(params[:password])
				if user.log_in
					if params[:forget_me_not]
						cookies.permanent[:sid] = user.session_token
					else
						cookies[:sid] = user.session_token
					end
					redirect_to root_path
					return

				else
					flash[:error] = "Something went wrong with authentication, please try again. If the problem persists, please contact the web admin."
				end
			else

				@errors << "Invalid email/password combination. Please try again."
			end
		else
			@errors << "You must provide a password."
		end

		render 'new'
	end

	def destroy
		current_user.log_out if current_user
		cookies.delete(:sid)
		redirect_to root_path
	end

end
