class AddColumnToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :description, :string
  end
end
