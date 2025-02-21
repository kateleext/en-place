# == Schema Information
#
# Table name: ingredients
#
#  id         :bigint           not null, primary key
#  ingredient :string
#  quantity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#
class Ingredient < ApplicationRecord
  #direct
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
end
