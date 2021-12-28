class StudentTerminalSubject < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :teacher
  belongs_to :term
  belongs_to :classroom

  after_create_commit { broadcast_append_to("student_terminal_subjects_list")}
  after_update_commit { broadcast_update_to("student_terminal_subjects_list")}
end
