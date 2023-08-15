class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :director
  has_many :movies_genres, dependent: :destroy
  has_many :genres, through: :movies_genres, dependent: :destroy
end
