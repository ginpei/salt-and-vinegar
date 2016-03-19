class ChangeUnitTypeInItems < ActiveRecord::Migration
  def up
    change_column :items, :unit, :string
  end
  def down
    change_column :items, :unit, :integer
  end
end
