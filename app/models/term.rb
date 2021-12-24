class Term < ApplicationRecord
  belongs_to :student
  
  validates :name, :start_date, :end_date, presence: true

  has_many :student_terminal_subjects_list
end
