class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :paper, index: true, null: false
      t.string :name, null: false
      t.string :quantity
      t.string :orderer

      t.timestamps null: false
    end
    add_foreign_key :items, :papers
  end
end
