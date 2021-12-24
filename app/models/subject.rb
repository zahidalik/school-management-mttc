class Subject < ApplicationRecord
  validates_presence_of :name, :credits

  has_many :student_terminal_subjects

  def to_s
    name
  end

  after_create_commit { broadcast_append_to("subjects_list")}
end
