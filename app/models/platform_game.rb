# Many-to-Many table between platforms and games.
class PlatformGame < ActiveRecord::Base

  belongs_to :game
  belongs_to :platform

  validates_uniqueness_of :game_id, scope: :platform_id

end
