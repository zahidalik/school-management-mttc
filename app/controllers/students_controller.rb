class StudentsController < ApplicationController

  def index
    @students = Student.all.order(first_name: :asc)
    @student = Student.new
  end

  def search
    if params.dig(:first_name_search).present?
      @students = Student.where('first_name ILIKE ?', "%#{params[:first_name_search]}%").order(first_name: :asc)
    else
      @students = []
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("search_results",
          partial: "students/search_results",
          locals: { students: @students })
        ]
      end
    end
  end

  def show
    @student = Student.find(params[:id])
    @student_terms = @student.terms.order(name: :asc)
    @all_subjects = Subject.all.order(name: :asc)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = StudentPdf.new(@student)
        send_data pdf.render,
          filename: "#{@student.first_name}.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
    # for producing qr code for the name of each student
    @student_name = @student.first_name + " " + @student.second_name + " " + @student.last_name
    @qrcode = RQRCode::QRCode.new(@student_name)

    # NOTE: showing with default options specified explicitly
    @svg = @qrcode.as_svg(
      color: "444",
      shape_rendering: "crispEdges",
      module_size: 1.5,
      standalone: true,
      use_path: true
    )
    # @png = @qrcode.as_png(
    #   bit_depth: 1,
    #   border_modules: 4,
    #   color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    #   color: "black",
    #   file: nil,
    #   fill: "white",
    #   module_px_size: 6,
    #   resize_exactly_to: false,
    #   resize_gte_to: false,
    #   size: 120
    # )
    # IO.binwrite("/tmp/student.png", @png.to_s)
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to student_path(@student)
    else
      render :edit
    end
  end

  def new
    @student = Student.new
    @suggested_admission_number = Student.last.admission_number + 1
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to students_url }
      end
    else
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :first_name, :second_name, :last_name,
      :father_name, :mother_name, :d_o_b,
      :birth_cert, :contact_one, :contact_two, :city,
      :region, :religion, :qualifications,
      :admission_date, :admission_number, :profile_pic
    )
  end
end
