module SessionsHelper

	def current_user
		return nil unless cookies[:session_id]
		User.find_by_session_id(cookies[:sid])
	end

end
