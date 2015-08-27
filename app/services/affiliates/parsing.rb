module Affiliates
  # Goes through the xml/json from GMG and gathers important information
  class Parsing

    def self.parse
      found = 0
      GMG_DATA.each do |gmg_game|
        game = Game.find_by(title: gmg_game[:name])
        if game
          found += 1
          game.gmg_url = URI.escape("#{ENV['GMG_AFFILIATE_LINK']}?url=#{gmg_game[:url]}")
          game.save
        end
      end
      return found
    end

  end
end
