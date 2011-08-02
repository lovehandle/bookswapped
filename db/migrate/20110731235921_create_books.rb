class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :ean
      t.string :title
      t.text :authors
      t.string :edition
      t.string :cover
      t.string :publisher
      t.integer :pages
      t.string :publication_date
      t.string :asin
      t.text :description

      t.timestamps
    end
  end
end
