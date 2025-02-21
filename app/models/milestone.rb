# == Schema Information
#
# Table name: milestones
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#
class Milestone < ApplicationRecord
  #direct
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  has_many  :tasks, class_name: "Task", foreign_key: "milestone_id", dependent: :destroy
end
