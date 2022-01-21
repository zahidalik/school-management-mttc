class Classroom < ApplicationRecord
  has_many :student_terminal_subjects
  has_many :students, through: :student_terminal_subjects
end
