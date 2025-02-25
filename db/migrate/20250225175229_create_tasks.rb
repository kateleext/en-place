class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.integer :milestone_id
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
