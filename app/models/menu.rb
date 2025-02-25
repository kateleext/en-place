class Menu < ApplicationRecord
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  belongs_to :recipe, required: true, class_name: "Recipe", foreign_key: "recipe_id"
end
