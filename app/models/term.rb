class Term < ApplicationRecord
  belongs_to :student
  validates :name, :start_date, :end_date, presence: true
end
