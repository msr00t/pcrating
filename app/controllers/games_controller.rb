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
      @reviews = @game.reviews.by_score.paginate(page: params[:page], per_page: 6)
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
    @game = Game.find_by(steam_appid: params[:game][:steam_appid])

    unless @game
      @game = Game.new(permitted_params.merge(user: current_user))
      @game.save
      @game.save
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

end
