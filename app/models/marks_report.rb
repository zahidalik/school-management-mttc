class MarksReport < ApplicationRecord
  belongs_to :student_terminal_subject
  validates_presence_of :written
end
