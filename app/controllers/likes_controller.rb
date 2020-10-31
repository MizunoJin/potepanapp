class LikesController < ApplicationController
  before_action :logged_in_user
 
  def create
    user = current_user
    @micropost = Micropost.find(params[:micropost_id])
    Like.create(user_id: user.id, micropost_id: @micropost.id)
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end
  
  def destroy
    user = current_user
    @micropost = Micropost.find(params[:micropost_id])
    like = Like.find_by(user_id: user.id, micropost_id: @micropost.id)
    like.delete
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end
    
   private
     def set_like
        @micropost = Micropost.find(params[:micropost_id])
     end
end
