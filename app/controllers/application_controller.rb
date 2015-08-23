# Application Controller
# Holds all of the various global pre-action functions
# TODO: Clean this up
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_location
  before_filter :banned?
  before_filter :ransack_setup
  before_action :authorize_profiler

  layout :layout

  def after_sign_in_path_for(_resource)
    session[:previous_url] || root_path
  end

  private

  def store_location
    return unless request.get?

    ignored_urls = [
      '/users/sign_in', '/users/sign_up', '/users/password/new',
      '/users/password/edit', '/users/confirmation', '/users/sign_out'
    ]

    return if ignored_urls.include?(request.path) || request.xhr?

    session[:previous_url] = request.fullpath
  end

  def banned?
    return unless current_user && current_user.banned?
    redirect_to root_path
  end

  # TODO: Clean this up. Move it into a service.
  def ransack_setup
    if params[:q]
      genre_name = params[:q][:genres_name_cont]
      decoded_genre_name = HTMLEntities.new.decode(genre_name)
      params[:q][:genres_name_cont] = decoded_genre_name

      if params[:q][:ranked_only] && params[:q][:ranked_only] == 'true'
        games = Game.rated
      else
        games = Game.all
      end

      # If we're sorting by release date then hide all games without
      # a release date. It's not great, but otherwise they cluster at the
      # start of the list as if they're the latest released games.
      if params[:q][:s] && params[:q][:s].include?('release_date')
        games = games.with_release_date
      end
    end


    @q = games.search(params[:q])
  end

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

  def authorize_profiler
    Rack::MiniProfiler.authorize_request if current_user && current_user.admin?
  end

end
