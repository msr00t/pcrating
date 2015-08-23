# A game category. This represents the different features a game can have
# at the time of writing the features in the database include:
# Single-player, Multi-player, Cross-Platform Multiplayer, and Co-op.
# There are several more. These are the things that display on the right bar
# on a game's steam page.
class Category < ActiveRecord::Base

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :category_games, dependent: :destroy
  has_many :games, through: :category_games

  def self.ransackable_attributes(auth_object = nil)
    return super if auth_object == :admin
    super & RANSACKABLE_ATTRIBUTES
  end

end
