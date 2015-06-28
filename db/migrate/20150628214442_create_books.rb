class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :token

      t.timestamps null: false
    end

    add_index :books, :token, unique: true

    add_column :papers, :book_id, :integer
    remove_column :papers, :token, :string
  end
end
