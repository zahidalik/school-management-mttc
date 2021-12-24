class AddCreditsToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :credits, :integer
  end
end
