defmodule BinanceEx.BookTicker do

  # {
  #   "symbol": "LTCBTC",
  #   "bidPrice": "4.00000000",
  #   "bidQty": "431.00000000",
  #   "askPrice": "4.00000200",
  #   "askQty": "9.00000000"
  # }

  defstruct [
    :symbol,
    :bid_price,
    :bid_quantity,
    :ask_price,
    :ask_qty
  ]

  use ExConstructor
end
