class CommentsController < ApplicationController
  def list
    micropost=Micropost.find_by(id:params[:id])
    render :json=>{:name=>"wangzixiao",:age=>23}
    #comments=micropost.comments.paginate(page:params[:page],per_page:8) ? micropost.comments : []
    #comment=micropost.comments.build
    #render :partial => "comment",:locals => { :comments => comments , :comment => comment}
  end
  def create

  end
  def destroy

  end
end
