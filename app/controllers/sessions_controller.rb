class SessionsController < ApplicationController
  def new

  end
  def create
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to user;
    else
      flash.now[:danger]="You got something wrong "
      render "new"
    end
  end
  def destroy

  end
end
