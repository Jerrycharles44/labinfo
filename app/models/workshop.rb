class Workshop < ActiveRecord::Base
    belongs_to :workshop_leader, class_name: "User"
    validates :workshop_leader_id, :name, :description, :level, presence: true
  end