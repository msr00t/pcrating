module SiteSettings
  # Handles creating, updating, and destroying various site settings
  class Manager

    def self.update(params)
      Settings.gmg_affiliate_link = params[:gmg_affiliate_link]
      Settings.reddit_link        = params[:reddit_link]
      Settings.landing_notice     = params[:landing_notice]
      Settings.twitter            = params[:twitter]
    end

    def self.get(setting_name)
      setting = Settings.send(setting_name)
      return nil if setting.blank?
      setting
    end

    def self.get_all
      Settings.get_all
    end

  end
end
