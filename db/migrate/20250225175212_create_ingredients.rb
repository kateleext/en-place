class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :quantity
      t.integer :event_id
      t.string :note

      t.timestamps
    end
  end
end
