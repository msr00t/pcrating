# Votes Controller
# Actions for interacting with the various votes on the site.
# All actions are used remotely.
# Actions: Upvote, Downvote
class VotesController < ApplicationController

  before_action :user?, except: [:show]
  before_action :setup_review

  def upvote
    if current_user.voted_up_on? @review
      @review.unliked_by current_user
    else
      @review.liked_by current_user
    end

    respond_to do |format|
      format.js { true }
    end
  end

  def downvote
    if current_user.voted_down_on? @review
      @review.undisliked_by current_user
    else
      @review.disliked_by current_user
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

  def setup_review
    @review = Review.find_by(id: params[:id])
    redirect_to root_path unless @review
  end

end
