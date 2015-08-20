class SiteController < ApplicationController

  before_action :game_slides

  def index
    flash[:alert] = ENV['LANDING_NOTICE'] unless flash[:alert]
  end

  private

    def game_slides
      @game_slides = [
        {
          title: 'Latest Games',
          games: Game.latest
        },
        {
          title: 'Top Games',
          games: Game.rated.top
        },
        {
          title: 'Worst Games',
          games: Game.rated.bottom
        },
      ]
    end

end
