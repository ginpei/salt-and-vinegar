class ChangeTitleOfPapers < ActiveRecord::Migration
  def up
    change_column :papers, :title, :string, null: true
  end
  def down
    change_column :papers, :title, :string, null: false
  end
end
