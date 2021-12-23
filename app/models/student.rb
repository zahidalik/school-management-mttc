class Student < ApplicationRecord
  validates :first_name, :second_name, :last_name,
            :father_name, :mother_name, :d_o_b,
            :contact_one, :city,
            :region, :religion, :qualifications,
            :admission_date, :admission_number,
            presence: true
  validates_uniqueness_of :admission_number

  has_many :terms
  
  after_create_commit { broadcast_append_to("students_list")}
end
