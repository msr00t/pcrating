# Developers Controller
# Actions for interacting with the various developers on the site
# Actions: Show
class DevelopersController < ApplicationController
  def show
    @developer = Developer.friendly.find(params[:id])
    @games = @developer.games.paginate(page: params[:page], per_page: 20)
  end
end
