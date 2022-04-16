class CreateStudentTerminalCocurriculums < ActiveRecord::Migration[7.0]
  def change
    create_table :student_terminal_cocurriculums do |t|
      t.string :teacher
      t.string :supervisor
      t.time :session_time
      t.string :start_day
      t.string :end_day
      t.string :venue
      t.references :student, null: false, foreign_key: true
      t.references :term, null: false, foreign_key: true
      t.references :cocurriculum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
