class AddDescriptionToPapers < ActiveRecord::Migration
  def change
    add_column :papers, :description, :text
  end
end
