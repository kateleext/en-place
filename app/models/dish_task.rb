# == Schema Information
#
# Table name: dish_tasks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dish_id    :integer
#  task_id    :integer
#
class DishTask < ApplicationRecord
  belongs_to :dish, required: true, class_name: "Dish", foreign_key: "dish_id"
  belongs_to :task, required: true, class_name: "Task", foreign_key: "task_id"
end
