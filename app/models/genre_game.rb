# Many-to-Many table between genres and games.
class GenreGame < ActiveRecord::Base

  belongs_to :game
  belongs_to :genre

  validates_uniqueness_of :game_id, scope: :genre_id

end
