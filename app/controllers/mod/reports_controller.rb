class Mod::ReportsController < Mod::ApplicationController

  def users
    @reports = Report.unhandled.users.paginate(page: params[:page], per_page: 10)
  end

  def reviews
    @reports = Report.unhandled.reviews.paginate(page: params[:page], per_page: 10)
  end

  def reject
    @report = Report.find_by(id: params[:id])
    @report.reject! if @report
    redirect_to :back
  end

end
