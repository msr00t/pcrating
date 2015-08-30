module Affiliates
  # Goes through the xml/json from GMG and gathers important information
  class Parsing

    def self.get_url_for_game(game)
      gmg_game = GMG_DATA.select { |gmg_game| gmg_game[:name] == game.title }
      return self.create_url(gmg_game[0][:url]) if gmg_game[0]
    end

    def self.create_url(url)
      affiliate_link = SiteSettings::Manager.get(:gmg_affiliate_link)

      URI.escape("#{affiliate_link}?url=#{url}")
    end

  end
end
