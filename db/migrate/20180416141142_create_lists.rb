class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.column :name, :string
      t.integer :user_id
    end
  end
end#class 
