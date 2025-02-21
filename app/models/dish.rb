# == Schema Information
#
# Table name: dishes
#
#  id          :bigint           not null, primary key
#  course      :string
#  description :string
#  recipe      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#
class Dish < ApplicationRecord
  #validations
  validates :event_id, presence: true

  #direct
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  has_many  :dish_tasks, class_name: "DishTask", foreign_key: "dish_id", dependent: :destroy
end
