class CreateDishes < ActiveRecord::Migration[7.1]
  def change
    create_table :dishes do |t|
      t.integer :event_id
      t.string :description
      t.string :course
      t.string :recipe

      t.timestamps
    end
  end
end
