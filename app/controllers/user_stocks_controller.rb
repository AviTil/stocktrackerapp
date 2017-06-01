class UserStocksController < ApplicationController


  def new
    @user_stock=UserStock.new
  end
  
  def create
    if params[:stock_id].present?
      @user_stock=UserStock.new(user: current_user, stock_id: params[:stock_id])
    else
      if Stock.find_by_ticker(params[:stock_ticker])
        @user_stock=UserStock.new(user: current_user, 
                          stock: Stock.find_by_ticker(params[:stock_ticker]))
      else 
        if Stock.new_from_lookup(params[:stock_ticker]).save
          @user_stock=UserStock.new(user: current_user, 
                          stock: Stock.new_from_lookup(params[:stock_ticker]))
        else
          @user_stock= nil
          flash[:danger]="Stock Unavailable"
        end    
      end
    end
    
    if @user_stock.save
      flash[:success]="You are now tracking this stock"
      redirect_to user_path(current_user)
    else
      flash[:danger]="Please check and try again"
      render 'new'
    end
      
  end
  
  def index
    @user_stocks=UserStock.all
  end
  
  def destroy
      @user_stock=UserStock.find(params[:id])
      @user_stock.destroy
      flash[:success]="No longer following this stock"
      redirect_to user_path(current_user)
  end
  
  def show
    #@user_stock=UserStock.find(params[:id])
  end

end