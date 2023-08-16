class AddMovieToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :movie_id, :bigint, after: "user_id", null: false
  end
end
