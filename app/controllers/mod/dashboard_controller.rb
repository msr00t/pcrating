module Mod
  # Mod Dashboard Controller
  # Actions for the mod dashboard
  # Actions: Index
  class DashboardController < Mod::ApplicationController

    def index
      @users   = Graphing::Stats.users
      @reviews = Graphing::Stats.reviews
      @games   = Graphing::Stats.games
      @ranks   = Graphing::Stats.ranks
    end

  end
end
