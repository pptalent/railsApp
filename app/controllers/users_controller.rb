class UsersController < ApplicationController
  def show
    @user=User.find(params[:id])
  end
  def new
    @user=User.new
  end
  def create
    @user=User.new(params_limit)
    if @user.save
      sign_in(@user)
      flash[:success]="Welcome to Wayne.twitter !"
      redirect_to @user
    else
      render "new"
    end
  end

  private
    def params_limit
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

end
