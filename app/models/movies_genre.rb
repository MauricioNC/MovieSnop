class MoviesGenre < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
  has_many :movies_genres
  has_many :genres, through: :movies_genres
end
