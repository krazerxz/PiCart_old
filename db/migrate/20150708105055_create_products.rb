class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :image
      t.boolean :details_found
      t.string :barcode

      t.timestamps null: false
    end
  end
end
