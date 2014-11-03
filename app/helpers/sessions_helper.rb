module SessionsHelper

	def current_user
		return nil unless cookies[:sid]
		User.find_by_session_token(cookies[:sid])
	end

end
