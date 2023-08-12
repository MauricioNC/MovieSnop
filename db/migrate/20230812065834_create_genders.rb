class CreateGenders < ActiveRecord::Migration[7.0]
  def change
    create_table :genders do |t|
      t.string :action
      t.string :animation
      t.string :crime
      t.string :commedy
      t.string :drama
      t.string :fiction_and_science
      t.string :horror
      t.string :musical
      t.string :sex
      t.string :romantic

      t.timestamps
    end
  end
end
