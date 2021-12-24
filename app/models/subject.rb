class Subject < ApplicationRecord
  validates_presence_of :name, :credits

  after_create_commit { broadcast_append_to("subjects_list")}
end
