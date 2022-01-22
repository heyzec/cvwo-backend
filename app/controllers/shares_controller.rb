class SharesController < ApplicationController

  # GET /.../share/:hash
  def index
    list = current_list
    tasks = list.tasks
    if list.nil?
      head :not_found and return
    end
    render json: {
      :list => list,
      :tasks => tasks
    }
  end
  
  # POST /.../share/:hash
  def create
  list = current_list
    begin
      current_user.lists << list
    rescue ActiveRecord::RecordNotUnique
      head :bad_request and return
    end
    head :ok
  end
  
  private
  def current_list
    List.find_by(share_hash: params[:hash])
  end

end
