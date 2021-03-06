class StocksController < ApplicationController

  def search
    if params[:stock]
      @stock = Stock.find_by_ticker(params[:stock])
      @stock ||= Stock.new_from_lookup(params[:stock])
    end
      
    if @stock
      #render json: @stock
      render partial: 'lookup'
    else 
      render status: :not_found, nothing: true
    end
    
  end
  
  def index
    @stocks=Stock.all
  end
  
  def show
    @stock=Stock.find(params[:id])
    @user_stock = current_user.user_stocks.find_by(stock_id: params[:id])
  end

end