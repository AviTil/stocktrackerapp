class SessionsController<ApplicationController
  def new
    
  end
  
  def create
    @user=User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id]=@user.id
      flash[:notice]="You are now logged in"
      redirect_to root_path
    else
      flash[:notice]="Please check your details and try again"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id]=nil
    flash[:notice]="You have successfully logged out"
    redirect_to root_path
  end
  
end