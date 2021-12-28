class StudentTerminalSubjectsController < ApplicationController

  def index
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subjects = @student.student_terminal_subjects.where(term_id: @term.id).order(:start_day)
  end

  def show
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subject = StudentTerminalSubject.find(params[:id])
  end

  def edit
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subject = StudentTerminalSubject.find(params[:id])
  end

  def update
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subject = StudentTerminalSubject.find(params[:id])

    if @student_terminal_subject.update(student_terminal_subjects_params)
      render @student_terminal_subject
      # respond_to do |format|
      #   format.turbo_stream
      #   format.html { redirect_to student_term_student_terminal_subjects_url(@student, @term) }
      # end
    else
      render :edit
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subject = StudentTerminalSubject.new
  end

  def create
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_subject = StudentTerminalSubject.new(student_terminal_subjects_params)
    @student_terminal_subject.student_id = @student.id
    @student_terminal_subject.term_id = @term.id

    if @student_terminal_subject.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to student_term_student_terminal_subjects_url(@student, @term) }
      end
    else
      render :new
    end
  end

  private

  def student_terminal_subjects_params
    params.require(:student_terminal_subject).permit(:teacher_id, :subject_id, :classroom_id, :period_time, :start_day, :end_day, :remarks)
  end
end
