class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :director
  has_many :movies_genres
  has_many :movies_genres, through: :movies_genres
end
