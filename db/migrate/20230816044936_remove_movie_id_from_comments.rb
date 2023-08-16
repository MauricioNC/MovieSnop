class RemoveMovieIdFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :movie_id
  end
end
