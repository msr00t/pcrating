class Mod::ReviewsController < Mod::ApplicationController

  def deleted
    @reviews = Review.only_deleted.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @review = Review.find_by(id: params[:id])

    @review.delete!(current_user)

    redirect_to :back
  end

end
