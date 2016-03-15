class AddCommentToItem < ActiveRecord::Migration
  def change
    add_column :items, :comment, :text
  end
end
