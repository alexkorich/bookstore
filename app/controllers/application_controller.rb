class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  helper_method :categories, :bestsellers

  def categories
    Category.all
  end

  rescue_from CanCan::AccessDenied do |exception|
    puts "SSSSSSSSSSSSSSSSSSSSSSSSS"
    puts request.format
      if user_signed_in?
        flash[:error] = "Sorry. but you are not authorized to view this page"
        session[:user_return_to] = nil
        redirect_to '/', content_type: "text/html"
      else
      if exception.message
       flash[:error] = exception.message
      else              
        flash[:error] = "You must first login to view this page"
      end
        session[:user_return_to] = request.url
        puts "WWWWWWWWWWWWWWWWWWw"

        if request.format=="application/json" || request.format=="application/javascript"
          puts "JSJSJSJJSJSJJSJSJSJSJSJSJS"
        render js: "window.location='#{new_user_session_path}'"
      else
        puts "HTHTHTHTHHTHTHTHTH"
        redirect_to new_user_session_path, format: "html"
      end
      end 
  end

  def after_sign_in_path_for(resource)
     root_path
  end

  unless Rails.application.config.consider_all_requests_local
     rescue_from ActionController::RoutingError, with: -> { render_404  }
   end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
     end
  end

 protected
  def configure_devise_permitted_parameters
    registration_params = [:firstname, :lastname, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end

end
