class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    tasks = Task.order("created_at ASC")
    render json: tasks
  end

  def create
    task = Task.new(task_param)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    task.update(task_param)
    render json: task
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    head :no_content, status: :ok
  end

  private
    def task_param
      params.require(:task).permit(:text, :day, :done)
    end
end