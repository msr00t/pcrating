module Mod
  # Mod Dashboard Controller
  # Actions for the mod dashboard
  # Actions: Index
  class DashboardController < Mod::ApplicationController

    def index
      @users   = Graphing::Data.users
      @reviews = Graphing::Data.reviews
      @games   = Graphing::Data.games
      @ranks   = Graphing::Data.ranks
    end

  end
end
