# Publishers Controller
# Actions for interacting with the various publishers on the site
# Actions: Show
class PublishersController < ApplicationController

  def show
    @publisher = Publisher.friendly.find(params[:id])
    @games = @publisher.games.paginate(page: params[:page], per_page: 20)
  end

end
