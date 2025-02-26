class Event < ApplicationRecord
  #direct
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :milestones, class_name: "Milestone", foreign_key: "event_id", dependent: :destroy
  has_many  :shopping_list, class_name: "Ingredient", foreign_key: "event_id", dependent: :destroy
  has_many  :menus, class_name: "Menu", foreign_key: "event_id", dependent: :destroy

  #indirect
  has_many :tasks, through: :milestones, source: :tasks
end
