class TagsController < ApplicationController
  before_action :ensure_current_user

  # GET /.../tags
  def index
    tags = current_user.tags.order("created_at ASC")
    render json: tags
  end

  # POST /.../tags
  def create
    if !current_user.tags.find_by(:text => tag_params[:text]).nil?
      head :conflict and return
    end

    tag = current_user.tags.new(tag_params)

    if tag.save
      render json: tag, status: :created
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH /.../tags/1
  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    render json: tag
  end

  # DELETE /.../tags/1
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content, status: :ok
  end


  private
    def tag_params  # Parameter white listing
      params.require(:tag).permit(:text, :color, :done)
    end
end
