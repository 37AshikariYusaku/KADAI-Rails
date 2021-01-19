class SessionsController < ApplicationController
  def new
  end
  
  def create
    # user = User.find_by(email: params[:session][:email])
    # if user && user.authenticate(params[:session][:password])
    user = User.find_by(login_email)
    if user && user.authenticate(login_password[:password])
      # authenticateメソッドの引数は文字列
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  
  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end  
  


  private
  def log_in(user)
    session[:user_id] = user.id
  end  
  
  def  log_out
    session.delete(:user_id)
    @current_user = nil
  end  
  
  def login_email
    params.require(:session).permit(:email)
  end
  
  def login_password
    params.require(:session).permit(:password)
  end
  

end  
