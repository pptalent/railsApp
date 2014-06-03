class SessionsController < ApplicationController
  def new

  end

  def create
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      create_new_url(user)
    else
      flash.now[:danger]="You got something wrong "
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
