class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all.order(name: :desc)
  end

  def excel_index
    @classrooms = Classroom.all.order(name: :desc)
    render xlsx: "excel_index", filename: "Classrooms", disposition: 'inline', template: "classrooms/excel_index"
  end

  def show
    @classroom = Classroom.find(params[:id])
    @classroom_terminal_subjects_without_duplication = @classroom.student_terminal_subjects.uniq do |class_subject|
                                                        class_subject.subject.name
                                                        #  class_subject.term.start_date
                                                        #class_subject.period_time
                                                       end
  
    @classroom_subjects = @classroom.student_terminal_subjects.all.order(subject_id: :desc)
   end

  # def classroom_timetables
  #   @classroom = Classroom.find(params[:id])
  #   @classroom_terminal_subjects_without_duplication = @classroom.student_terminal_subjects.uniq do |class_subject|
  #     class_subject.subject.name
  #     #  class_subject.term.start_date
  #     #class_subject.period_time
  #    end
  # end

  # def classroom_students
  #   @classroom = Classroom.find(params[:id])
  #   @classroom_subjects = @classroom.student_terminal_subjects
  # end

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
