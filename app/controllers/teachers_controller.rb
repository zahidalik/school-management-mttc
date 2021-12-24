class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all.order(:joining_date)
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      render @teacher
    else
      render :edit
    end
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to teachers_url}
      end
    else
      render :new
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:full_name, :contact_no, :full_address, :staff_quarter, :joining_date)
  end
end
