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
    widths = [150,90,90,40,60,100]
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
      text "STUDENT’S ACADEMIC AND PERSONAL PROGRESS CARD", align: :center
    end
    move_down 15
    text "<font size='16' name='Helvetica'><b><u>#{@student.first_name} #{@student.second_name} #{@student.last_name}</u></b></font>", inline_format: true, align: :center
    text "<font size='13' name='Times-Roman'>#{@term.name}, #{@term.end_date.strftime("%B %Y")}</font>", inline_format: true, align: :center
    
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

    heading = [["Subject", "Written Exam", "Oral Exam", "Total", "Credits", "Remarks"]]
    table(heading, column_widths: widths) do
      row(0).border_width = 2
      row(0).font_style = :bold
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end

    overall_marks = 0
    marks_with_credits = 0
    total_credits = 0
    @student_terminal_subjects.each do |sub|
      overall_marks += sub.marks_report.total
      total_credits += sub.subject.credits
      marks_with_credits += sub.marks_report.total * sub.subject.credits
    
      table([ [sub.subject.name, sub.marks_report.written, sub.marks_report.oral, sub.marks_report.total, sub.subject.credits, sub.marks_report.remarks ]], column_widths: widths) do
        row(0).font = 'Helvetica'
        row(0).size = 12
        column(1..4).align = :center
      end
    end

    percentage_by_credits = (marks_with_credits / total_credits).round(1)

    case percentage_by_credits
    when 90..100
      grade = "A+"
    when 80..89
      grade = "A"
    when 70..79
      grade = "B"
    when 60..69
      grade = "C"
    when 50..59
      grade ="D"
    when 0..49
      grade = "Fail"
    end

    table_input = [["Grand Total of Marks: #{overall_marks}", "Percentage by credits: #{percentage_by_credits}", "Grade: #{grade}"]]
    table(table_input, width: 530) do
      row(0).border_width = 2
      row(0).font_style = :bold
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end
    
    move_down 13

    table([["Class teacher's comment:"], ["Head of MTTC:"]], width: 530)

    data = [["Description", "Grade", "Description", "Grade"],
            ["Attendance in prayers", " ", "Participation in competitions", ""],
            ["Behaviour in dormitory", " ", "Respect to others", " "],
            ["Care of property", " ", "Honesty", " "],
            ["Cleanliness", " ", "Akhlaq", " "],
            ["Hijab", " ", "Overall grade", " "],
            ["School closes on", " ", "School reopens on", " "]]
    
    move_down 13

    table(data, width: 530) do
      row(0).font_style = :bold
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end
    
    move_down 10

    legend = [["A+ = 90% - 100%", "A = 80% - 89%", "B = 70% - 79%", "C = 60% - 69%", "D = 50% - 59%", "Fail = 0% - 49%"]]
    
    table(legend, width: 530) do
      row(0).background_color = "DCDCDC"
      row(0).align = :center
    end
  end
end