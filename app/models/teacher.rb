class Teacher < ApplicationRecord
  validates_presence_of :full_name, :contact_no, :staff_quarter

  def to_s
    full_name
  end

  has_many :student_terminal_subjects

  after_create_commit { broadcast_append_to("teachers_list")}
  after_update_commit { broadcast_update_to("teachers_list")}
end
