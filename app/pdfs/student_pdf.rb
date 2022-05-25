class StudentPdf
  include Prawn::View

  def initialize(student)
    # font_setup # this is a new line
    super()
    @student = student
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
    # widths = [100,90,90]
    # cell_height = 20

    widths = [130,120,90,90,110]
    cell_height = 15

    logo = "app/assets/images/logo.png" 
    image logo, at: [12,720], height: 70

    if @student.profile_pic.present?
      profile_pic = ActiveStorage::Blob.service.send(:path_for, @student.profile_pic.key)
      image profile_pic, at: [459, 720], width: 70, height: 70
    end

    text "<font size='10' name='Times-Roman'>In the name of Almighty (SWT)</font>", inline_format: true, align: :center
    move_down 5
    font('Helvetica', size: 13) do
      text "WALIUL ASR EDUCATION CENTRE", align: :center
      move_down 5
      text "MUSLIM TEACHER TRAINING COURSE", align: :center, style: :bold
      move_down 5
      text "STUDENT’S OVERALL ACADEMIC PROGRESS CARD", align: :center
    end
    move_down 15

    text "<font size='16' name='Helvetica'><b><u>#{@student.first_name} #{@student.second_name} #{@student.last_name}</u></b></font>", inline_format: true, align: :center
    # bounding_box([0, cursor], width: 400, height: 90) do
    #   stroke_bounds
    #   move_down 10
    # text "Father's Name: #{@student.father_name}, Mother's Name: #{@student.mother_name},
    # DOB: #{@student.d_o_b}, Birth Certificate: #{@student.birth_cert},
    # Contact: #{@student.contact_one}, Another contact no:#{@student.contact_two},
    # Address: #{@student.city}", align: :center
    # end
    # @student.region
    # @student.religion
    # @student.qualifications
    # @student.admission_date
    # @student.admission_number}"
    move_down 20
    
    heading = [["Subject", "Term", "Ending in", "Total Marks", "Remarks" ]]
    table(heading, column_widths: widths) do
      row(0).border_width = 2
      row(0).font_style = :bold
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end
    @student.student_terminal_subjects.map do |sub|
      if !!sub.marks_report
        table([ [sub.subject.name, sub.term.name, sub.term.end_date.strftime("%b %Y"), sub.marks_report.total, sub.marks_report.remarks] ], column_widths: widths) do
          row(0).font = 'Helvetica'
          row(0).size = 12
          column(1..3).align = :center
        end
      else
        table([ [sub.subject.name, sub.term.name, sub.term.end_date.strftime("%b %Y"), "N/A", "Results awaited"] ], column_widths: widths) do
          row(0).font = 'Helvetica'
          row(0).size = 12
          column(1..3).align = :center
        end
      end
    end

    overall_marks = 0
    marks_with_credits = 0
    total_credits = 0
    @student.student_terminal_subjects.map do |sub|
      total_credits += sub.subject.credits
      if !!sub.marks_report
        overall_marks += sub.marks_report.total
        marks_with_credits += sub.marks_report.total * sub.subject.credits
      else
        next
      end
    end

    percentage_by_credits = (marks_with_credits / total_credits).round(1)

    if @student.student_terminal_subjects.any? {|sub| !!sub.marks_report }
      case percentage_by_credits
      when 90.0..100
        grade = "A+"
      when 80.0..89.9
        grade = "A"
      when 70.0..79.9
        grade = "B"
      when 60.0..69.9
        grade = "C"
      when 50.0..59.9
        grade ="D"
      when 0.0..49.9
        grade = "Fail"
      end
    else
      grade = "N/A"
    end

    table_input = [["Grand Total of Marks: #{overall_marks}", "Percentage by credits: #{percentage_by_credits}", "Grade: #{grade}"]]
    table(table_input, width: 540) do
      row(0).border_width = 2
      row(0).font_style = :bold
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end
  end
end