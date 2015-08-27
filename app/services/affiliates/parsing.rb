module Affiliates
  # Goes through the xml/json from GMG and gathers important information
  class Parsing

    def self.get_url_for_game(game)
      gmg_game = GMG_DATA.select { |gmg_game| gmg_game[:name] == game.title }[0]
      return self.create_url(gmg_game[:url])
    end

    def self.create_url(url)
      URI.escape("#{ENV['GMG_AFFILIATE_LINK']}?url=#{url}")
    end

  end
end
