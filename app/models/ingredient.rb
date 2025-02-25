class Ingredient < ApplicationRecord
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  has_many  :recipe_ingredients, class_name: "RecipeIngredient", foreign_key: "ingredient_id", dependent: :destroy
end
