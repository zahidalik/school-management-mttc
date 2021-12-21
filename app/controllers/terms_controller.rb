class TermsController < ApplicationController

  def new
    @student = Student.find(params[:student_id])
    @term = Term.new
  end

  def create
    @student = Student.find(params[:student_id])
    @term = Term.new(term_params)
    @term.student_id = @student.id
    if @term.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new
    end
  end

  private
  
  def term_params
    params.require(:term).permit(:name, :start_date, :end_date)
  end
end