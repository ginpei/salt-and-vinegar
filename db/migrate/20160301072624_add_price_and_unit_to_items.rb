class AddPriceAndUnitToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :integer
    add_column :items, :unit, :integer
  end
end
