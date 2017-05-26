class UsersController < ApplicationController

before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user=User.new 
  end
  
  def create
    @user=User.new(user_params)
    if @user.save
      flash[:notice]="Welcome to Stock Tracker"
      session[:user_id]=@user.id
      redirect_to user_path(@user)
    else
      flash[:notice]="Please check your details"
      render 'new'
    end
  end
  
  def show
    @user=User.find(params[:id])
  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="Your details were updated"
      redirect_to user_path(@user)
    else
      flash[:danger]="Something went wrong - please try again"
      render 'edit'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
  
  def require_same_user
    if current_user != User.find(params[:id])
      flash[:danger]="You may only edit basic info for yourself"
      redirect_to user_path(User.find(params[:id]))
    end
  end
  
end
  
