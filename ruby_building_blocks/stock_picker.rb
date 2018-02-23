# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. 
# It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

def stock_picker(prices)

  profit = 0

  (prices.length - 1).times do |i|

    curr_buy_price = prices[0]
    prices.delete_at(0)

    if prices.max - curr_buy_price > profit
      profit = prices.max - curr_buy_price
      buy_index = i
      sell_index = i + prices.index(prices.max) + 1
      @best_days = [buy_index, sell_index]
    end

  end

  p @best_days
  
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])