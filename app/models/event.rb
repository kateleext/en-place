# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :text
#  event_date  :date
#  guest_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Event < ApplicationRecord

  #direct
  belongs_to :host, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :dishes, class_name: "Dish", foreign_key: "event_id", primary_key: "id", dependent: :destroy
  has_many  :milestones, class_name: "Milestone", foreign_key: "event_id", dependent: :destroy
  has_many  :shopping_list, class_name: "Ingredient", foreign_key: "event_id", dependent: :destroy

  #indirect
  has_many :tasks, through: :milestones, source: :tasks
end
