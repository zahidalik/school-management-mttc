class Student < ApplicationRecord
  validates :first_name, :second_name, :last_name,
            :father_name, :mother_name, :d_o_b,
            :birth_cert, :contact_one, :city,
            :region, :religion, :qualifications,
            :admission_date, :admission_number,
            presence: true
end
