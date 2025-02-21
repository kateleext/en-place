class CreateDishTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :dish_tasks do |t|
      t.integer :dish_id
      t.integer :task_id

      t.timestamps
    end
  end
end
