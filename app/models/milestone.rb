class Milestone < ApplicationRecord
  belongs_to :event, required: true, class_name: "Event", foreign_key: "event_id"
  has_many  :tasks, class_name: "Task", foreign_key: "milestone_id", dependent: :destroy
end
