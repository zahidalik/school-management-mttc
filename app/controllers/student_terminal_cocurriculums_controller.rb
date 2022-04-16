class StudentTerminalCocurriculumsController < ApplicationController
  def new
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_cocurriculum = StudentTerminalCocurriculum.new
  end

  def create
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student_terminal_cocurriculum = StudentTerminalCocurriculum.new(student_terminal_cocurriculums_params)
    @student_terminal_cocurriculum.student_id = @student.id
    @student_terminal_cocurriculum.term_id = @term.id

    if @student_terminal_cocurriculum.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to student_term_student_terminal_subjects_url(@student, @term) }
      end
    else
      render :new, status: :bad_request
    end
  end

  private

  def student_terminal_cocurriculums_params
    params.require(:student_terminal_cocurriculum).permit(:teacher, :supervisor, :cocurriculum_id, :venue, :session_time, :start_day, :end_day)
  end
end
