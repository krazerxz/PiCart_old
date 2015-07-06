class CreateBarcodes < ActiveRecord::Migration
  def change
    create_table :barcodes do |t|
      t.integer :upc

      t.timestamps null: false
    end
  end
end
