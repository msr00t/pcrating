module Admin
  # Admin Reviews Controller
  # Actions for interacting with Reviews as an admin
  # Actions: Restore, Destroy
  class ReviewsController < Admin::ApplicationController

    def restore
      @review = Review.only_deleted.find_by(id: params[:id])

      @review.restore! if @review

      redirect_to :back
    end

    def destroy
      @review = Review.only_deleted.find_by(id: params[:id])

      @review.really_destroy! if @review

      redirect_to :back
    end

  end
end
