class TasksController < ApplicationController
  before_action :ensure_current_user
  
  # GET /.../tasks
  def index
    # tasks = current_user.tasks.order("created_at ASC")
    tasks = current_user.lists.map{|x| x.tasks}.flatten
    render json: tasks
  end

  # POST /.../tasks
  def create
    # Active Record Associations - this is similar to:
    # task = Task.new(task_params); task.user_id = current_user.id
    task = current_user.tasks.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  # PATCH /.../tasks/1
  def update
    task = Task.find(params[:id])
    task.update(task_params)
    render json: task
  end

  # DELETE /.../tasks/1
  def destroy
    task = Task.find(params[:id])
    task.destroy
    head :no_content, status: :ok
  end


  private
    def task_params  # Parameter white listing
      params.require(:task).permit(:text, :day, {:tags => []}, :done)
    end
end
