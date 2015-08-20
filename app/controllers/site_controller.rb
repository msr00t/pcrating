class SiteController < ApplicationController

  before_action :game_slides
  before_action :graphs

  def index
    flash[:alert] = ENV['LANDING_NOTICE'] unless flash[:alert]
  end

  private

    def game_slides
      @game_slides = Rails.cache.fetch("landing slides", expires_in: 2.hours) do
        [
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

    def graphs
      @scores = Rails.cache.fetch("graphing scores", expires_in: 24.hours) do
        Reviews::Graphing.scores.to_s
      end

      @ranks =  Rails.cache.fetch("graphing ranks", expires_in: 24.hours) do
        Reviews::Graphing.ranks.to_s
      end
    end

end
