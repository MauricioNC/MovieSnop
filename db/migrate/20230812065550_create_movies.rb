class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :duration
      t.string :thriller_link
      t.date :public_date

      t.timestamps
    end
  end
end
