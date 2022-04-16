class CreateCocurriculums < ActiveRecord::Migration[7.0]
  def change
    create_table :cocurriculums do |t|
      t.string :name
      t.text :strategies

      t.timestamps
    end
  end
end
