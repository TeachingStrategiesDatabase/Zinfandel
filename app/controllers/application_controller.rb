class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	include SessionsHelper

	# Prevent CSRF for cookies other than session
	def handle_unverified_request
		super
		current_user.log_out if current_user
	end

	protected

	# before_filters go here, so that they are available to all controllers

	def logged_in
		redirect_to login_path, :notice => "You are not logged in." unless current_user
	end

	def user_owns_strategy
		redirect_to login_path, :notice => "Please log in to the correct account." unless current_user.is_author?(Strategy.find(params[:id])) || current_user.is_admin?
	end

	def user_is_admin
		redirect_to root_path, :notice => "You must be admin to view this page." unless current_user.is_admin?
	end

end
