# Games Controller
# Actions for interacting with the various games on the site
# Actions: Index, Show, Edit, New, Create, Destroy
class GamesController < ApplicationController

  before_action :user?, except: [:index, :show]
  before_action :admin?, only: [:destroy]
  before_action :setup_game, except: [:index, :new, :create]

  layout :layout

  def index
    @games = @q.result.paginate(page: params[:page], per_page: 20)
  end

  def show
    if @game
      sorted_reviews = @game.reviews.by_score
      @reviews = sorted_reviews.paginate(page: params[:page], per_page: 6)
      @stat_hash = Reviews::GameRanker.new(@game).stat_hash
    else
      @game = Game.new(steam_appid: params[:steam_appid])
      render :new
    end
  end

  def edit
  end

  def new
    @game = Game.new
  end

  def create
    unless Game.find_by(steam_appid: params[:game][:steam_appid])
      @game = Game.create(merged_permitted_params)
      flash[:error] = @game.errors.full_messages[0]
    end
    redirect_to game_path(id: @game.slug)
  end

  def destroy
    @game.destroy
  end

  private

  def layout
    return 'fill_page' unless params[:action] == 'show'
    'application'
  end

  def user?
    flash[:success] = 'Login or signup to continue'
    redirect_to new_user_session_path unless current_user
  end

  def admin?
    redirect_to root_path unless current_user.admin?
  end

  def setup_game
    @game = Game.friendly.find(params[:id])
  end

  def permitted_params
    params.require(:game).permit(:steam_appid)
  end

  def merged_permitted_params
    permitted_params.merge(user: current_user)
  end

end
