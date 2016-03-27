class AddCurrencyToPapers < ActiveRecord::Migration
  def up
    add_column :papers, :currency, :string
    rename_column :books, :currency, :default_currency
  end
  def down
    remove_column :papers, :currency
    rename_column :books, :default_currency, :currency
  end
end
