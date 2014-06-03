module SessionsHelper
  def sign_in(user)
    remember_token=User.create_remember_token
    cookies.permanent[:remember_token]=remember_token
    user.update_attribute(:remember_token,User.digest_remember_token(remember_token))
  end

  def sign_out
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user=user
    @wzx="wangzixiao0821"
  end

  def current_user
    remember_token=cookies[:remember_token]
    @current_user||=User.find_by(remember_token:User.digest_remember_token(remember_token))
    return @current_user
  end

  def sign_in?
    !current_user.nil?
  end

  def is_current_user?(user)
    user==current_user
  end

  def create_new_url(default)
    if session[:redirect_to]
      redirect_to session[:redirect_to]
      session.delete(:redirect_to)
    else
      flash[:success]="Login success"
      redirect_to default
    end
  end

end
