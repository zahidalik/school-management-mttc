class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all.order(:name)
  end

  def show
    @classroom = Classroom.find(params[:id])
  end

  def edit
    @classroom = Classroom.find(params[:id])
  end

  def update
    @classroom = Classroom.find(params[:id])
    if @classroom.update(classroom_params)
      render @classroom
    else
      render :edit
    end
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to classrooms_url }
      end
    else
      render :new
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
