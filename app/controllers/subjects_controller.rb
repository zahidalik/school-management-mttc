class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all  
  end

  def new
    @subject = Subject.new
  end

  def create
    
  end
end
