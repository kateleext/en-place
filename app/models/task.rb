# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  description  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  milestone_id :integer
#
class Task < ApplicationRecord
  #direct
  has_many  :dish_tasks, class_name: "DishTask", foreign_key: "task_id", dependent: :destroy
  belongs_to :milestone, required: true, class_name: "Milestone", foreign_key: "milestone_id"

  #indirect
  has_one  :event, through: :milestone, source: :event
end
