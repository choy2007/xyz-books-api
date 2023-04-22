class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.decimal :price
      t.string :publication_year
      t.references :publisher, null: false, index: true, foreign_key: true
      t.string :image_url
      t.string :edition

      t.timestamps
    end
  end
end
