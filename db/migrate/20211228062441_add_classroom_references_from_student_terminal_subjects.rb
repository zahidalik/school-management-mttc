class AddClassroomReferencesFromStudentTerminalSubjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :student_terminal_subjects, :classroom, foreign_key: true
  end
end
