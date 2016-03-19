class ChangePriceTypeOfItems < ActiveRecord::Migration
  def up
    change_column :items, :price, :float
  end
  def down
    change_column :items, :price, :integer
  end
end
