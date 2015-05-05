class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
