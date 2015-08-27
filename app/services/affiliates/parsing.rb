module Affiliates
  # Goes through the xml/json from GMG and gathers important information
  class Parsing

    def self.parse_all
      found = 0
      GMG_DATA.each do |gmg_game|
        game = Game.find_by(title: gmg_game[:name])
        if game
          found += 1
          game.gmg_url = self.create_url(gmg_game[:url])
          game.save
        end
      end
      return found
    end

    def self.get_url_for_game(game)
      gmg_game = GMG_DATA.select { |gmg_game| gmg_game[:name] == game.title }[0]
      return self.create_url(gmg_game[:url])
    end

    def self.create_url(url)
      URI.escape("#{ENV['GMG_AFFILIATE_LINK']}?url=#{url}")
    end

  end
end
