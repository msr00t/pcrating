module Admin
  # Admin Settings Controller
  # Actions for editing the site's various settings
  # Actions: Edit, Update
  class SettingsController < Admin::ApplicationController

    def edit
    end

    def update
      SiteSettings::Manager.update(params)

      redirect_to :back
    end

  end
end
