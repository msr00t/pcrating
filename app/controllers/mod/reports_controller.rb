class ReportsController < ModController

  def index
    @reports = Report.all.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @report = Report.find_by(id: params[:id])

    @report.destroy

    redirect :back
  end

end
