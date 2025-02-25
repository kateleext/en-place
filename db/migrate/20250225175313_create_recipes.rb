class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :reference_url
      t.text :ingredients
      t.text :steps
      t.text :note

      t.timestamps
    end
  end
end
