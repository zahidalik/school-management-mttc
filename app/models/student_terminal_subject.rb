class StudentTerminalSubject < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :teacher
  belongs_to :term

  after_create_commit { broadcast_append_to("student_terminal_subjects_list")}
end
