class LockersController < ApplicationController

  before_action :login_check
  before_action :get_teacher
  before_action :get_locker, only: [:show, :edit, :update, :destroy]

  private
  
  def get_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
  
  def locker_params
    params.require(:locker).permit(:locker_number, :compartment)
  end
  
  def get_locker
    @locker = @teacher.locker
    if @locker.nil?
     redirect_to new_teacher_locker_path(@teacher),  alert: "sorry no locker available ! please create a locker"
    end
  end
  
  public
  
  def index
    @locker = @teacher.locker
  end
  
  def edit
  end
  
  def update
    if @locker.update_attributes(locker_params)
      # redirect_to teacher_locker_url(@teacher, @locker), notice: "successfully updated...."
      redirect_to [@teacher, @locker], notice: "successfully updated...."
    else
      flash.now[:alert] = "please correctly fill the fields"
      render action: :edit
    end
  end
  
  def create
    @locker = Locker.new(locker_params)
    @locker.teacher = @teacher
    if @locker.save
      redirect_to teacher_locker_url(@teacher, @locker)
    else
      flash.now[:alert] = "please correctly fill the fields"
      render action: :new
    end
  end
  
  def new
    @locker = Locker.new
  end
  
  def destroy
    @locker.destroy
    redirect_to teacher_path(@teacher), notice: "succefully deleted the locker"
  end
  
end
