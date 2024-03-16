# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
def stock_picker(stock_prices)
  low_price = stock_prices.first
  curr_buy = nil
  max_profit = 0
  curr_sell = nil
  out = [0, 0]
  stock_prices.each_with_index do |price, i|
    # current price is lower
    # set as new low
    if price <= low_price
      low_price = price
      curr_buy = i
      next
    end
    # profit on this day is not higher than max
    # skip this iteration
    next if price - low_price <= max_profit

    max_profit = price - low_price
    curr_sell = i
    out[0] = curr_buy
    out[1] = curr_sell
  end
  out
end
# rubocop:enable Metrics/MethodLength

p stock_picker([17, 3, 4, 1, 9, 15, 8, 6, 1, 10, 18])
p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 55, 44, 56])
p stock_picker([17, 16, 6, 4, 2, 1])
