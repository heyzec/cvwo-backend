class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    tags = Tag.order("created_at ASC")
    render json: tags
  end

  def create
    tag = Tag.new(tag_param)
    if tag.save
      render json: tag, status: :created
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_param)
    render json: tag
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    head :no_content, status: :ok
  end

  private
    def tag_param
      params.require(:tag).permit(:text, :color, :done)
    end
end
