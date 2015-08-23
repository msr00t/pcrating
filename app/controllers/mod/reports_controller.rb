module Mod
  # Mod Reports Controller
  # Actions for interacting with user reports
  # Actions: Users, Reviews, Reject
  class ReportsController < Mod::ApplicationController

    def users
      reported_users = Report.unhandled.users
      @reports = reported_users.paginate(page: params[:page], per_page: 10)
    end

    def reviews
      reported_reviews = Report.unhandled.reviews
      @reports = reported_reviews.paginate(page: params[:page], per_page: 10)
    end

    def reject
      @report = Report.find_by(id: params[:id])
      @report.reject! if @report
      redirect_to :back
    end

  end
end
