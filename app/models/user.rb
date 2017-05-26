class User < ActiveRecord::Base
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6, maximum: 25 }
  
  def can_add_stock? (ticker_symbol)
    stocks_under_limit? && !stock_already_added?(ticker_symbol)
  end
  
  def stocks_under_limit?
    (user_stocks.count < 10)
  end
  
  def stock_already_added? (ticker_symbol)
    stock=Stock.find_by_ticker (ticker_symbol)
    return false unless stock
    user_stocks.where(stock_id: stock.id).exists?
  end
  
end