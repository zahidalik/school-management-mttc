class AddJoiningDateToTeachers < ActiveRecord::Migration[7.0]
  def change
    add_column :teachers, :joining_date, :date
  end
end
