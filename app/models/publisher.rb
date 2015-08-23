# A game publisher. Has many games. Data for this is gathered from the steam
# api.
# Is Ransackable via Games on the search screen. Only the name column is
# ransackable.
class Publisher < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  RANSACKABLE_ATTRIBUTES = %w(name)

  has_many :publisher_games, dependent: :destroy
  has_many :games, through: :publisher_games

  def self.ransackable_attributes(auth_object = nil)
    if auth_object == :admin
      super
    else
      super & RANSACKABLE_ATTRIBUTES
    end
  end

end
