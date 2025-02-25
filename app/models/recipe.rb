class Recipe < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :menus, class_name: "Menu", foreign_key: "recipe_id", dependent: :destroy
  has_many  :recipe_ingredients, class_name: "RecipeIngredient", foreign_key: "recipe_id", dependent: :destroy
  has_many  :associated_tasks, class_name: "RecipeTask", foreign_key: "recipe_id", dependent: :destroy
end
