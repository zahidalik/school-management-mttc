class ClassroomsController < ApplicationController
  def index
    @classrooms =  Classroom.all.order(name: :desc)
  end

  def excel_index
    @classrooms = Classroom.all.order(name: :desc)
    render xlsx: "excel_index", filename: "Classrooms", disposition: 'inline', template: "classrooms/excel_index"
  end

  def show
    @classroom = Classroom.find(params[:id])
    @classroom_for_starting_dates = @classroom.student_terminal_subjects.uniq do |class_subject|
      class_subject.term.start_date
      #class_subject.period_time
     end
  end

  def search_for_timetable
    @classroom = Classroom.find(params[:id])
    @classroom_subjects = @classroom.student_terminal_subjects 
    if params.dig(:start_date_search).present?
      @classroom_without_duplication = @classroom.student_terminal_subjects.uniq do |class_subject|
        class_subject.subject.name
        #  class_subject.term.start_date
        #class_subject.period_time
       end
      @classroom_timetable = @classroom_without_duplication.filter_map do |s|
        s if s.term.start_date == params[:start_date_search].to_date
      end
    else
      @classroom_timetable = []
    end
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("search_results_for_timetable",
          partial: "classrooms/search_results_for_timetable",
          locals: { classroom_timetable: @classroom_timetable })
        ]
      end
    end
  end

  def search_for_attendance
    @classroom = Classroom.find(params[:id])
    @classroom_subjects = @classroom.student_terminal_subjects
    if params.dig(:subject_search).present?
      @classroom_attendance_per_subject = @classroom_subjects.filter_map do |s|
        s if s.subject.name.downcase.include?("#{params[:subject_search].downcase}")
      end  
      if params.dig(:start_date_search).present?
        @classroom_attendance_per_subject = @classroom_subjects.filter_map do |s|
          s if s.subject.name.downcase.include?("#{params[:subject_search].downcase}") && s.term.start_date == params[:start_date_search].to_date
        end
      end
    elsif params.dig(:start_date_search).present?
      @classroom_attendance_per_subject = @classroom_subjects.filter_map do |s|
        s if s.term.start_date == params[:start_date_search].to_date
      end
    else
      @classroom_attendance_per_subject = []
    end
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("search_results_for_attendance",
          partial: "classrooms/search_results_for_attendance",
          locals: { classroom_attendance_per_subject: @classroom_attendance_per_subject })
        ]
      end
    end
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
