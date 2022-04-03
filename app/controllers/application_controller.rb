class ApplicationController < ActionController::Base
      # Make the current_user method available to views also, not just controllers:
  helper_method :current_user
  
  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  #authorize method redirects user to login page
  def authorize
    puts request.fullpath
    redirect_to root_path,alert: ["You must login to access the page."] if current_user.nil? && request.fullpath != '/login'
  end
  # def redirect_cancel
  #   redirect_to register_path if params[:cancel]
  # end
end
