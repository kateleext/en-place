class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.integer :event_id
      t.integer :recipe_id
      t.string :remarks

      t.timestamps
    end
  end
end
