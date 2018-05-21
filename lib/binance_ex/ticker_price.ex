defmodule BinanceEx.TickerPrice do

  # {
  #   "symbol": "LTCBTC",
  #   "price": "4.00000200"
  # }

  defstruct [
    :symbol,
    :price
  ]

  use ExConstructor
end
