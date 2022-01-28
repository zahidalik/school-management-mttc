class StudentTerminalSubjectsPdf
  include Prawn::View

  def initialize(student, term, student_terminal_subjects)
    # font_setup # this is a new line
    super()
    @student = student
    @term = term
    @student_terminal_subjects = student_terminal_subjects
    content
  end

  # This is the new method with font declaration
  # def font_setup
  #   font_families.update("NotoSans" => {
  #     :normal => "vendor/assets/fonts/NotoSans-Regular.ttf",
  #     :italic => "vendor/assets/fonts/NotoSans-Italic.ttf",
  #     :bold => "vendor/assets/fonts/NotoSans-Bold.ttf",
  #   })
  #   font "NotoSans"
  # end

  def content
    widths = [90,50,100,50,50,40,100]
    cell_height = 15
    font('Helvetica', size: 12) do
      text "Name: #{@student.first_name} #{@student.second_name} #{@student.last_name}", align: :center
      text "Term: #{@term.name}", align: :center
    end

    # bounding_box([0, cursor], width: 400, height: 90) do
    #   stroke_bounds
    #   move_down 10
    #   text "Father's Name: #{@student.father_name}, Mother's Name: #{@student.mother_name},
    #   DOB: #{@student.d_o_b}, Birth Certificate: #{@student.birth_cert},
    #   Contact: #{@student.contact_one}, Another contact no:#{@student.contact_two},
    #   Address: #{@student.city}", align: :center
    # end
    # @student.region
    # @student.religion
    # @student.qualifications
    # @student.admission_date
    # @student.admission_number}"
    move_down 10
    heading = [["Subject", "Credits", "Teacher", "Classroom", "From", "To", "Time", "Remarks"]]
    table(heading, column_widths: widths) do
      row(0).border_width = 2
      row(0).font_style = :bold
    end
    @student_terminal_subjects.each do |sub|
      table([ [sub.subject.name, sub.subject.credits, sub.teacher.full_name, sub.classroom.name, sub.start_day, sub.end_day, sub.period_time.strftime("%I:%M %P"), sub.remarks ]], column_widths: widths) do
        row(0).font = 'Helvetica'
        row(0).size = 12
      end
    end
  end
end