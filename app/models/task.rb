class Task < ApplicationRecord
  has_many  :associated_recipes, class_name: "RecipeTask", foreign_key: "task_id", dependent: :destroy
  belongs_to :milestone, required: true, class_name: "Milestone", foreign_key: "milestone_id"

  #indirect
  has_one  :event, through: :milestone, source: :event
end
