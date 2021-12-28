class AddPeriodTimeStartDayEndDayToStudentTerminalSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :student_terminal_subjects, :period_time, :time
    add_column :student_terminal_subjects, :start_day, :string
    add_column :student_terminal_subjects, :end_day, :string
  end
end
