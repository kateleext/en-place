class CreateRecipeTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_tasks do |t|
      t.integer :recipe_id
      t.integer :task_id

      t.timestamps
    end
  end
end
