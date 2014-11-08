class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	include SessionsHelper

	protected

	# before_filters go here, so that they are available to all controllers

	def logged_in
		redirect_to root_path, :notice => "You are not logged in." unless current_user
	end

	def user_is_admin
		redirect_to root_path, :notice => "You must be admin to view this page." unless current_user.is_admin?
	end

end
