class StudentsController < ApplicationController
  
  def show
    @student = Student.find(params[:id])  
  end
  
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :first_name, :second_name, :last_name,
      :father_name, :mother_name, :d_o_b,
      :birth_cert, :contact_one, :contact_two, :city,
      :region, :religion, :qualifications,
      :admission_date, :admission_number
    )
  end
end