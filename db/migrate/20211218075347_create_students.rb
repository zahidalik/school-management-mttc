class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :second_name
      t.string :last_name
      t.string :father_name
      t.string :mother_name
      t.date :d_o_b
      t.boolean :birth_cert
      t.integer :contact_one
      t.integer :contact_two
      t.string :city
      t.string :region
      t.string :religion
      t.string :qualifications
      t.date :admission_date
      t.integer :admission_number

      t.timestamps
    end
  end
end
