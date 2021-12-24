class StudentsController < ApplicationController

  def index
    @students = Student.all.order(:admission_date)
    @student = Student.new
  end
  
  def show
    @student = Student.find(params[:id])
    @student_terms = @student.terms.order(:name)
  end
  
  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      render @student
    else
      render :edit
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to students_url }
      end
    else
      render :new
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