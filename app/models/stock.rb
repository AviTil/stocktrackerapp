class Stock < ActiveRecord::Base

  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  validates :ticker, uniqueness: true

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  def self.new_from_lookup(ticker_symbol)
    return nil unless StockQuote::Stock.quote(ticker_symbol).name
    new_stock=new(ticker: ticker_symbol,
                  name: StockQuote::Stock.quote(ticker_symbol).name)
    new_stock.last_price=new_stock.price
    new_stock
  end
  
  def price
    return StockQuote::Stock.quote(ticker).close if StockQuote::Stock.quote(ticker).close
    return StockQuote::Stock.quote(ticker).previous_close if StockQuote::Stock.quote(ticker).previous_close
    "Unavailable"
  end
  
end