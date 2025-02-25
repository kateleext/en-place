class RecipeIngredient < ApplicationRecord
  belongs_to :ingredient, required: true, class_name: "Ingredient", foreign_key: "ingredient_id"
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
end
