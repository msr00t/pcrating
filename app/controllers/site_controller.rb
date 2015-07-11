class SiteController < ApplicationController

  def index
    @top_games = Game.top[0..1]
    @games = Game.rated
    flash[:alert] = ENV['LANDING_NOTICE'] unless flash[:alert]
  end

end
