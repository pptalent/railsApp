class RelationshipsController < ApplicationController
  before_action :log_in_first
  def create
      @user=User.find_by(id:params[:relationship][:followed_id])
      current_user.followed!(@user)
      if !params[:relationship][:index].nil?
        redirect_to users_path
      else
        redirect_to @user
      end

  end

  def destroy
      @user=Relationship.find_by(id:params[:id]).followed
      current_user.unfollow!(@user)
      if params[:relationship].nil?
        redirect_to @user
      else
        if !params[:relationship][:index].nil?
          redirect_to users_path
        else
          redirect_to @user
        end
      end


  end
end
