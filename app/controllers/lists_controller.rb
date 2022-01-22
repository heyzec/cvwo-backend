class ListsController < ApplicationController
  before_action :ensure_current_user

  # GET /.../lists
  def index
    lists = current_user.lists
    output = lists.map do |list|
      hash = list.as_json.update("shared": list.share_hash.nil?)
      hash.delete("share_hash")
      hash
    end
    render json: output
  end

  # POST /.../lists
  def create
    list = List.new(list_params)
    list.users << current_user
    if list.save
      render json: list, status: :created
    else
      render json: list.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH /.../lists/1
  def update
    list = List.find(params[:id])
    list.update(task_params)
    render json: list
  end

  # Antipattern!
  # POST /.../lists/1/create
  def create_task
    list = List.find(params[:list_id])
    task = list.tasks.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end
  
  # POST /.../lists/1/share
  def share
    list = List.find(params[:list_id])
    if list.share_hash.nil?
      list.generate_share_hash
    else
      hash = list.share_hash
    end
    render plain: hash
  end


  # DELETE /.../lists/1
  def destroy
    list = List.find(params[:id])
    current_user.lists.delete(list)
    head :no_content, status: :ok
  end

  private
  def list_params  # Parameter white listing
    params.require(:list).permit(:text)
  end

  # Antipattern!
  def task_params  # Parameter white listing
    params.permit(:text, :day, {:tags => []}, :done)
  end
end
