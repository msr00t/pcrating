# Review Controller
# Actions for interacting with the various reviews on the site
# Actions: Show, Edit, New, Create, Update, Report, Destroy
class ReviewsController < ApplicationController

  before_action :user?, except: [:show]

  def show
    @game = Game.find_by(slug: params[:game_id])
    @review = Review.find_by(id: params[:id], game: @game)
  end

  def edit
    @game = Game.find_by(slug: params[:game_id])
    @review = Review.find_by(user: current_user, game: @game)

    redirect_to game_path(id: @game.slug) unless @review
  end

  def new
    @game = Game.find_by(slug: params[:game_id])

    if current_user.deleted_review?(@game) || !@game.released?
      redirect_to game_path(id: @game.slug)
    end

    @review = @game.reviews.find_or_initialize_by(user_id: current_user.id)

    render 'edit' if @review.persisted?
  end

  def create
    @game = Game.find_by(slug: params[:game_id])
    redirect_to game_path(id: @game.slug) unless @game.released?

    @review = Review.new(permitted_params)
    @review.user = current_user
    @review.game = @game

    if @review.save
      redirect_to game_review_path(game_id: @review.game, id: @review.id)
    else
      render :new
    end
  end

  def update
    @game = Game.find_by(slug: params[:game_id])
    redirect_to game_path(id: @game.slug) unless @game.released?

    @review = Review.find_by(user: current_user, game: @game)

    if @review.update_attributes(permitted_params)
      redirect_to game_review_path(game_id: @review.game, id: @review.id)
    else
      render :edit
    end
  end

  def report
    @review = Review.find_by(id: params[:review_id])

    @review.report!(current_user)

    respond_to do |format|
      format.js { true }
    end
  end

  def destroy
    @game = Game.find_by(slug: params[:game_id])
    @review = Review.find_by(id: params[:id], user: current_user)

    if @review
      @review.without_auditing do
        @review.really_destroy!
      end
    end

    redirect_to game_path(id: @game.slug)
  end

  private

  def user?
    flash[:success] = 'Login or signup to continue'
    redirect_to new_user_session_path unless current_user
  end

  def owned_by_user?
    redirect_to root_path unless @review.user == current_user
  end

  def permitted_params
    params.require(:review).permit(STATS.keys + [:review])
  end

end
