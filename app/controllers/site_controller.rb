# Site Controller
# Actions for the static pages on the site
# Actions: Index (Landing Page)
class SiteController < ApplicationController

  before_action :game_slides
  before_action :graphs

  def index
    current_landing_notice = SiteSettings::Manager.get(:landing_notice)

    unless  session[:users_last_landing_notice] == current_landing_notice ||
            flash[:alert]
      flash[:alert] = current_landing_notice
      session[:users_last_landing_notice] = current_landing_notice
    end
  end

  private

  def game_slides
    @game_slides = [
      { title: 'Top Games',    games: Game.top    },
      { title: 'Latest Games', games: Game.latest },
      { title: 'Worst Games',  games: Game.bottom }
    ]
  end

  def graphs
    @scores = Rails.cache.fetch('graphing scores', expires_in: 24.hours) do
      Graphing::Data.scores
    end

    @ranks = Rails.cache.fetch('graphing ranks', expires_in: 24.hours) do
      Graphing::Data.ranks
    end
  end

end
