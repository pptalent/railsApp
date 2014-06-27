class MicropostsController < ApplicationController
  before_action :log_in_first,only:[:create,:destroy]
  def create
    #build(content:params[:micropost][:content])
    @micropost=current_user.microposts.build(limit_params)
    if @micropost.save
      redirect_to root_path
    else
      render "static_page/home"
    end
  end
  def destroy
    @micropost=current_user.microposts.find_by(id:params[:id])
    if !@micropost.nil?
      @micropost.destroy
    end
    redirect_to user_path(current_user)
  end
  def limit_params
    #post过来的params中取出micropost这个key，然后只用里面content这个key
    params.require(:micropost).permit(:content)
  end
end
