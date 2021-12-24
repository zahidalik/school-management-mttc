class ChangeBirthCertToBeStringInStudents < ActiveRecord::Migration[7.0]
  def up
    change_column :students, :birth_cert, :string
  end

  def down
    change_column :students, :birth_cert, :boolean
  end
end
