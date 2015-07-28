class PublishersController < ApplicationController

  def show
    @publisher = Publisher.friendly.find(params[:id])
    @games = @publisher.games.paginate(page: params[:page], per_page: 20)
  end

end
