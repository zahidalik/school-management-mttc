class TermsController < ApplicationController
  def edit
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:id]) 
  end

  def update
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:id])
    if @term.update(term_params)
      render @term
    else
      render :edit
    end
  end

  def new
    @student = Student.find(params[:student_id])
    @term = Term.new
  end

  def create
    @student = Student.find(params[:student_id])
    @term = @student.terms.new(term_params)
    if @term.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to student_url(@student)}
      end
    else
      render :new
    end
  end

  private
  
  def term_params
    params.require(:term).permit(:name, :start_date, :end_date, :student_id)
  end
end