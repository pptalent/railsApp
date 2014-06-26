
class CommentsController < ApplicationController
  include ActionView::Helpers::DateHelper
  def list
    @micropost=Micropost.find_by(id:params[:id])
    @comments=@micropost.comments ? @micropost.comments.paginate(:page=>params[:page],:per_page=>99999) : []
    @comment=@micropost.comments.build
    render :partial => "comments/comment"
  end
  def create
    @comment=current_user.comments.build(params_limit)
    if @comment.save
      user_name=@comment.user.name
      created_at=time_ago_in_words(@comment.created_at)
      render :json=>{:result=>true,:content=>{:comment_id=>@comment.id,
                                                :micropost_id=>@comment.micropost_id,
                                                :user_id=>@comment.user_id,
                                                :user_name=>user_name,
                                                :content=>@comment.content,
                                                :created_at=>created_at
        }}
    else
        render :json=>{:result=>false,:content=>@comment.errors}
    end
  end
  def destroy
    comment=Comment.find_by(id:params[:id])
    if !comment.nil?
      comment.destroy
      render :json=>{:result=>true}
    else
      render :json=>{:result=>false}
    end
  end

  private
    def params_limit
      params.permit(:content,:micropost_id)
    end
end
