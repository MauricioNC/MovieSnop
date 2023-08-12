class ChangeGenreTableStructure < ActiveRecord::Migration[7.0]
  def change
    drop_table :genres, force: :cascade
    create_table :genres do |t|
      t.string :genre
    
      t.timestamps
    end
    
  end
end
