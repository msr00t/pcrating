class SiteController < ApplicationController

  layout 'landing'

  def index
    @top_games = Game.top[0..1]
    @games = Game.all
    flash[:alert] = ENV['LANDING_NOTICE'] unless flash[:alert]
  end

end
