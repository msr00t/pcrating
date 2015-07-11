class VotesController < ApplicationController

  before_action :user?, except: [:show]
  before_action :setup_rating

  layout false

  def upvote
    if current_user.voted_up_on? @rating
      @rating.unliked_by current_user
    else
      @rating.liked_by current_user
    end

    respond_to do |format|
      format.js { true }
    end
  end

  def downvote
    if current_user.voted_down_on? @rating
      @rating.undisliked_by current_user
    else
      @rating.disliked_by current_user
    end

    respond_to do |format|
      format.js { true }
    end
  end

  private

  def user?
    flash[:success] = 'Login or signup to continue'
    redirect_to new_user_session_path unless current_user
  end

  def setup_rating
    @rating = Rating.find_by(id: params[:id])
    redirect_to root_path unless @rating
  end

end
