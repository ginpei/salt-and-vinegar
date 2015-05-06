class ChangeTokenColumnOfPaper < ActiveRecord::Migration
  def up
    Paper.all.each do |paper|
      paper.add_token
      paper.save
    end
    change_column :papers, :token, :string, null: false
    add_index :papers, :token, unique: true
  end

  def down
    remove_index :papers, :token
    change_column :papers, :token, :string, null: true
    Paper.all.each do |paper|
      paper.token = nil
      paper.save
    end
  end
end
