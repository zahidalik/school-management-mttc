class Term < ApplicationRecord
  belongs_to :student
  
  validates :name, :start_date, :end_date, presence: true

  has_many :student_terminal_subjects
  has_many :student_terminal_cocurriculums

  def to_s
    name
  end
end
