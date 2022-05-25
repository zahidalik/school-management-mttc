class MarksReportController < ApplicationController
  def show
    @marks_report = MarksReport.find(params[:id])
  end

  def edit
    @student_terminal_subject = StudentTerminalSubject.find(params[:student_terminal_subject_id])
    @marks_report = MarksReport.find(params[:id])
  end

  def update
    @student_terminal_subject = StudentTerminalSubject.find(params[:student_terminal_subject_id])
    @marks_report = MarksReport.find(params[:id])
    if @marks_report.update(marks_params)
      if @marks_report.written.present? && @marks_report.oral.present?
        total = @marks_report.written + @marks_report.oral
        @marks_report.update(total: total)
      elsif @marks_report.written.present?
        total = @marks_report.written
        @marks_report.update(total: total)
      elsif @marks_report.oral.present?
        total = @marks_report.oral
        @marks_report.update(total: total)
      else
        total = 0
        @marks_report.update(total: total)
      end
      redirect_to student_term_student_terminal_subjects_url(@student_terminal_subject.student, @student_terminal_subject.term)
    end
  end
  
  def new
    @student_terminal_subject = StudentTerminalSubject.find(params[:student_terminal_subject_id])
    @marks_report = MarksReport.new
  end

  def create
    @student_terminal_subject = StudentTerminalSubject.find(params[:student_terminal_subject_id])
    @student = @student_terminal_subject.student
    @term = @student_terminal_subject.term
    @marks_report = MarksReport.new(marks_params)
    @marks_report.student_terminal_subject_id = @student_terminal_subject.id
    if @marks_report.written.present? && @marks_report.oral.present?
      @marks_report.total = @marks_report.written + @marks_report.oral
    elsif @marks_report.written.present? 
      @marks_report.total = @marks_report.written
    elsif @marks_report.oral.present?
      @marks_report.total = @marks_report.oral
    else
      @marks_report.total = 0
    end

    if @marks_report.save
      respond_to do |format|
        format.turbo_stream
      end
      # flash[:notice] = "Marks report submitted successfully!"
      # redirect_to student_term_student_terminal_subjects_url(@student_terminal_subject.student, @student_terminal_subject.term)
    else
      flash.now[:alert] = "Something went wrong!"
      render :new, status: :bad_request
    end
  end

  # def destroy
  #   @marks_report = MarksReport.find(params[:id])

  #   if @marks_report.delete
  #     redirect_to student_terminal_subject_marks_report_url(@marks_report.student_terminal_subject, @marks_report)
  #   end
  # end

  private

  def marks_params
    params.require(:marks_report).permit(:written, :oral, :remarks)
  end
end