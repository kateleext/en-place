class RecipeTask < ApplicationRecord
  belongs_to :task, required: true, class_name: "Task", foreign_key: "task_id"
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
end
