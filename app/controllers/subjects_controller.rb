class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all.order(:name)
  end

  def new
    @subject = Subject.new
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      render @subject
    else
      render :edit
    end
  end

  def create
    @subject = Subject.new(subject_params)
    
    if @subject.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to subjects_url}
      end
    else
      render :new
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :book, :credits)
  end
end
