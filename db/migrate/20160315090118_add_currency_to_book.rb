class AddCurrencyToBook < ActiveRecord::Migration
  def change
    add_column :books, :currency, :string
  end
end
