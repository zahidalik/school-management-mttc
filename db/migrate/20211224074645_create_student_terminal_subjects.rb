class CreateStudentTerminalSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :student_terminal_subjects do |t|
      t.time :period_time
      t.references :student, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
