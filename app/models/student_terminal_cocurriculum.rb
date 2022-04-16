class StudentTerminalCocurriculum < ApplicationRecord
  belongs_to :student
  belongs_to :term
  belongs_to :cocurriculum

  after_create_commit { broadcast_append_to("student_terminal_cocurriculums_list")}
  after_update_commit { broadcast_update_to("student_terminal_cocurriculums_list")}
end
