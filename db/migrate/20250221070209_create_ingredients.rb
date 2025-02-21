class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :ingredient
      t.string :quantity
      t.integer :event_id

      t.timestamps
    end
  end
end
