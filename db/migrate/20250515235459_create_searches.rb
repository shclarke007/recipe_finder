class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :ingredients
      t.string :category
      t.string :author
      t.string :ratings

      t.timestamps
    end
  end
end
