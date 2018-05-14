defmodule BinanceEx.Trade do

  # {
  #   "id": 28457,
  #   "price": "4.00000100",
  #   "qty": "12.00000000",
  #   "time": 1499865549590,
  #   "isBuyerMaker": true,
  #   "isBestMatch": true
  # }

  defstruct [:id, :price, :qty, :time, :isBuyerMaker, :isBestMatch]

  use ExConstructor
end
