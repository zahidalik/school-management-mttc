class CreateTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.string :full_name
      t.string :contact_no
      t.string :full_address
      t.string :qualification
      t.string :staff_quarter

      t.timestamps
    end
  end
end
