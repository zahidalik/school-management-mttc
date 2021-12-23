class Teacher < ApplicationRecord
  validates_presence_of :full_name, :contact_no, :staff_quarter

  after_create_commit { broadcast_append_to("teachers_list")}
end
