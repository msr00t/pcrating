class SiteController < ApplicationController

  before_action :game_slides

  def index
    flash[:alert] = ENV['LANDING_NOTICE'] unless flash[:alert]
  end

  private

    def game_slides
      games = Game.rated

      @game_slides = [
        {
          title: 'Latest Games',
          games: games.latest[0..1]
        },
        {
          title: 'Top Games',
          games: games.top[0..1]
        },
        {
          title: 'Worst Games',
          games: games.bottom[0..1]
        },
      ]
    end

end
