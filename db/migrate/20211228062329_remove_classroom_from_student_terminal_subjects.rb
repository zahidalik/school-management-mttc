class RemoveClassroomFromStudentTerminalSubjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :student_terminal_subjects, :classroom
  end
end
