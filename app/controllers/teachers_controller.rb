class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all.order(full_name: :asc)
  end

  def show
    @teacher = Teacher.find(params[:id])
    @teacher_terminal_subjects_without_duplication = @teacher.student_terminal_subjects.uniq do |class_subject|
      # class_subject.subject.name
      # class_subject.term.name
      class_subject.period_time
      # class_subject.classroom.name
    end
  end
  
  def workload
    @teacher = Teacher.find(params[:id])
    @teacher_terminal_subjects_without_duplication = @teacher.student_terminal_subjects.uniq do |class_subject|
      # class_subject.subject.name
      # class_subject.term.name
      class_subject.period_time
      # class_subject.classroom.name
    end
    render xlsx: "workload", filename: "#{@teacher.full_name}", disposition: 'inline', template: "teachers/workload"
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
