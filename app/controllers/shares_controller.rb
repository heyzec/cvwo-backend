class SharesController < ApplicationController

  # GET /.../share/:hash
  def index
    list = current_list
    if list.nil?
      head :not_found and return
    end
    
    # Don't just return a list of strings, find the tag objects from the first user with this list, remove ids
    tags = get_tags_hashed(list)
    
    render json: {
      :list => list,
      :tasks => list.tasks,
      :tags => tags
    }
  end
  
  # POST /.../share/:hash 
  # User accepts the list, so link it to the user
  def create
    list = current_list
    begin
      current_user.lists << list
    rescue ActiveRecord::RecordNotUnique
      head :bad_request and return
    end
    
    # If user importing the list does not have the tags in the list, create tags for this user based of
    # the color of the first user (author)
    get_tags_hashed(list).each do |tag|
      if current_user.tags.find_by(:text => tag["text"]).nil?
        current_user.tags.create(tag)
      end
    end
    head :ok
  end

  # POST /.../lists/1/share
  def share_list
    list = List.find(params[:list_id])
    if list.share_hash.nil?
      hash = list.generate_share_hash
    else
      hash = list.share_hash
    end
    render plain: hash
  end
  
  private
  def current_list
    List.find_by(share_hash: params[:hash])
  end
  

  # From a list, retrieve a hashed form of the tag. These objects are not associated with any user.
  # The color is (probably) based off the author's tag colors, but in the case the author deleted the
  # tags already, find the color from any other user.
  private
  def get_tags_hashed(list)
    tags = []
    list.tags.each do |tag_text|
      t = list.users.first.tags.find_by(:text => tag_text)
      if t.nil?
        t = Tag.find_by(:text => tag_text)
      else
      tags << t.as_json.slice("text", "color")
      end
    end
    tags
  end
  
end
