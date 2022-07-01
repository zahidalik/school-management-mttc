class StaticPagesController < ApplicationController
  skip_before_action :authenticate_admin!
  def home
    @student_count = Student.count
    @teacher_count = Teacher.count
    @subject_count = Subject.count
    @credit_count = Subject.sum(:credits)
  end
end
