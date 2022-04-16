class CocurriculumsController < ApplicationController
  def index
    @cocurriculums = Cocurriculum.all
  end
  
  def new
    @cocurriculum = Cocurriculum.new
  end

  def create
    @cocurriculum = Cocurriculum.new(cocurriculum_params)
    if @cocurriculum.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cocurriculums_url}
      end
    else
      render :new
    end
  end

  private

  def cocurriculum_params
    params.require(:cocurriculum).permit(:name, :strategies)
  end
end