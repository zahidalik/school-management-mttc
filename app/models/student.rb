class Student < ApplicationRecord
  validates :first_name, :second_name, :last_name,
            :father_name, :mother_name, :d_o_b,
            :contact_one, :city,
            :region, :religion, :qualifications,
            :admission_date, :admission_number,
            presence: true
  validates_uniqueness_of :admission_number

  has_many :terms
  has_many :student_terminal_subjects
  
  after_create_commit { broadcast_append_to("students_list")}
  after_update_commit { broadcast_update_to("students_list")}

  def total_credits(student)
    credits = 0
    student.student_terminal_subjects.each do |s|
      credits += s.subject.credits
    end
    credits
  end

  def credits_in_current_term(student, term)
    credits = 0
    student_terminal_subjects = student.student_terminal_subjects.where(term_id: term.id)
    student.student_terminal_subjects.each do |s|
      credits += s.subject.credits
    end
    credits
  end
end
