class ChangeContactToBeStringInStudents < ActiveRecord::Migration[7.0]
  def change
    change_column :students, :contact_one, :string
    change_column :students, :contact_two, :string
  end
end
