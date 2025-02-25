class CreateMilestones < ActiveRecord::Migration[7.1]
  def change
    create_table :milestones do |t|
      t.integer :event_id
      t.string :name

      t.timestamps
    end
  end
end
