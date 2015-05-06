class AddTokenToPaper < ActiveRecord::Migration
  def change
    add_column :papers, :token, :string
  end
end
