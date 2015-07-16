class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_location
  before_filter :banned?
  before_filter :ransack_setup

  layout :layout

  def store_location
    return unless request.get?

    ignored_urls = [
      '/users/sign_in', '/users/sign_up', '/users/password/new',
      '/users/password/edit', '/users/confirmation', '/users/sign_out'
    ]

    return if ignored_urls.include?(request.path) || request.xhr?

    session[:previous_url] = request.fullpath
  end

  def after_sign_in_path_for(_resource)
    session[:previous_url] || root_path
  end

  def banned?
    return unless current_user && current_user.banned?
    redirect_to 'https://www.google.co.uk/webhp#q=you%27vebeenbanned'
  end

  def ransack_setup
    params[:q][:genres_name_cont] = HTMLEntities.new.decode params[:q][:genres_name_cont] if params[:q]

    if params[:q] && params[:q][:ranked_only] == 'true'
      @q = Game.rated.ransack(params[:q])
    else
      @q = Game.ransack(params[:q])
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  def layout
    return 'fill_page' unless application_layout?
    'application'
  end

  def application_layout?
    application_layouts = [
      %w(site index),
      %w(game show)
    ]
    application_layouts.include? [params[:controller], params[:action]]
  end

end
