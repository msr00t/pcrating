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

    def graphs
      @scores = Rails.cache.fetch("graphing scores", expires_in: 24.hours) do
        raw Reviews::Graphing.scores.to_s
      end

      @ranks =  Rails.cache.fetch("graphing ranks", expires_in: 24.hours) do
        raw Reviews::Graphing.ranks.to_s
      end
    end

end
