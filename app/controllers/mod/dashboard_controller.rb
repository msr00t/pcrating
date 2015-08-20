class Mod::DashboardController < Mod::ApplicationController

  def index
    @rank_data = Rails.cache.fetch("mod ranks", expires_in: 1.hour) do
      Reviews::Graphing.pretty_html_ranks
    end
    @users   = Reviews::Graphing.users
    @reviews = Reviews::Graphing.reviews
    @games   = Reviews::Graphing.games
    @ranks   = Reviews::Graphing.ranks
  end

end
