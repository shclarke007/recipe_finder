class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :cook_time
      t.integer :prep_time
      t.string :ratings
      t.text :ingredients
      t.string :author
      t.string :category
      t.string :cuisine
      t.string :image

      t.timestamps
    end
  end
end
