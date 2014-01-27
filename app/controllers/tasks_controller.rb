class TasksController < ApplicationController
  
  before_action :get_teacher
  before_action :login_check
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  private
  
  def get_teacher
    @teacher = Teacher.find(params[:teacher_id])
    access_denied unless @teacher
  end
  
  def task_params
    params.require(:task).permit(:title, :description, :priority)
  end
  
  def get_task
    @task = @teacher.tasks.where(id: params[:id]).first
    access_denied unless @task
  end
  
  public
  
  def index
    @tasks = @teacher.tasks
  end
  
  def new
    @task = Task.new
  end
  
  def edit
  end
  
  def update
    if @task.update_attributes(task_params)
      # redirect_to teacher_task_url(@teacher, @task), notice: "successfully updated...."
      redirect_to [@teacher, @task], notice: "successfully updated...."
    else
      flash.now[:alert] = "please correctly fill the fields"
      render action: :edit
    end
  end
  
  def create
    @task = Task.new(task_params)
    @task.teacher = @teacher
    if @task.save
      redirect_to teacher_task_url(@teacher, @task)
    else
      flash.now[:alert] = "please correctly fill the fields"
      render action: :new
    end
  end
  
  def destroy
    @task.destroy
    redirect_to teacher_tasks_path, notice: "succefully deleted the task"
  end


end
