class AddClassroomToStudentTerminalSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :student_terminal_subjects, :classroom, :string
  end
end
