class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.float :rate
      t.string :name
      t.integer :book_id

      t.timestamps null: false
    end
    create_table :items_taxes do |t|
      t.integer :item_id
      t.integer :tax_id

      t.timestamps null: false
    end
  end
end
