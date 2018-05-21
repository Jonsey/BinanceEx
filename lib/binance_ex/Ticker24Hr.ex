defmodule BinanceEx.Ticker24Hr do

  # {
  #   "symbol": "BNBBTC",
  #   "priceChange": "-94.99999800",
  #   "priceChangePercent": "-95.960",
  #   "weightedAvgPrice": "0.29628482",
  #   "prevClosePrice": "0.10002000",
  #   "lastPrice": "4.00000200",
  #   "lastQty": "200.00000000",
  #   "bidPrice": "4.00000000",
  #   "askPrice": "4.00000200",
  #   "openPrice": "99.00000000",
  #   "highPrice": "100.00000000",
  #   "lowPrice": "0.10000000",
  #   "volume": "8913.30000000",
  #   "quoteVolume": "15.30000000",
  #   "openTime": 1499783499040,
  #   "closeTime": 1499869899040,
  #   "fristId": 28385,   // First tradeId
  #   "lastId": 28460,    // Last tradeId
  #   "count": 76         // Trade count
  # }

  defstruct [
    :symbol,
    :price_change,
    :price_change_percent,
    :weigthed_avg_price,
    :prev_close_price,
    :last_price,
    :last_qty,
    :bid_price,
    :ask_price,
    :open_price,
    :high_price,
    :low_price,
    :volume,
    :quote_volume,
    :open_time,
    :close_time,
    :first_id,
    :last_id,
    :count
  ]

  use ExConstructor
end
