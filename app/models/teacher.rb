class Teacher < ApplicationRecord
  validates_presence_of :full_name, :contact_no, :staff_quarter

  def to_s
    full_name
  end

  has_many :student_terminal_subjects

  after_create_commit { broadcast_append_to("teachers_list")}
end
