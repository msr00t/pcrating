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
          games: Game.latest[0..1]
        },
        {
          title: 'Top Games',
          games: Game.rated.top[0..1]
        },
        {
          title: 'Worst Games',
          games: Game.rated.bottom[0..1]
        },
      ]
    end

end
