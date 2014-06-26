class UsersController < ApplicationController
  before_action :log_in_first,only:[:edit,:update,:index]
  before_action :correct_user,only:[:edit,:update]

  def index
      @users=User.paginate(page:params[:page],:per_page=>23)
  end

  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page:params[:page],:per_page=>10)
  end
  def new
    @user=User.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(params_limit)
      flash[:success]="Yes! U Change success"
      redirect_to @user
    else
      render "edit"
    end
  end

  def create;
    @user=User.new(params_limit)
    if @user.save
      sign_in(@user)
      flash[:success]="Welcome to PPTwitter !"
      redirect_to @user
    else
      render "new"
    end
  end

  private
    def params_limit
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end


    def correct_user
      @user=User.find(params[:id])
      if !is_current_user?(@user)
         redirect_to root_url
      end
    end

end
