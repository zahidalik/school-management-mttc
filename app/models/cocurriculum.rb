class Cocurriculum < ApplicationRecord
  validates_presence_of :name

  has_many :student_terminal_cocurriculums

  after_create_commit { broadcast_append_to("cocurriculums_list")}
  after_update_commit { broadcast_update_to("cocurriculums_list")}

  def to_s
    name
  end
end
