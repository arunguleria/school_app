class TeachersController < ApplicationController
  
  before_action :login_check
  before_action :get_teacher, only: [:show, :edit, :update, :destroy]
  private
  
  def get_teacher
    @teacher = Teacher.where(id: params[:id]).first
    if @teacher.nil?
      redirect_to teachers_path, alert: "sorry we couldn't find this teacher"
    end
  end
  
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :age, :gender)
  end
  
  public
  
  def index
    @teachers = Teacher.all
  end
  
  def new
    @teacher = Teacher.new
  end
  
  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save

       redirect_to teacher_url(@teacher), notice: "Successfully created teacher."
    else
      flash.now[:alert] = "Please correctly fill the form"
      render action: :new
    end
  end
  
  def edit
  end
  
  def update
    if @teacher.update_attributes(teacher_params)
      redirect_to teacher_url(@teacher), notice: "Successfully updated teacher."
    else
      flash.now[:alert] = "Please correctly fill the form"
      render action: :edit
    end
  end
  
  def destroy
    @teacher.destroy
    redirect_to teachers_path, notice: "Successfully deleted the teacher"
  end


end
