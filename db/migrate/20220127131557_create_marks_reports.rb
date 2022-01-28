class CreateMarksReports < ActiveRecord::Migration[7.0]
  def change
    create_table :marks_reports do |t|
      t.float :written
      t.float :oral
      t.float :total
      t.string :remarks
      t.references :student_terminal_subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
