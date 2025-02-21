class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.date :event_date
      t.integer :guest_count
      t.text :description

      t.timestamps
    end
  end
end
