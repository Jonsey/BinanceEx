defmodule BinanceEx.Orderbook do
  defstruct [:bids, :asks, :last_update_id]

  use ExConstructor
end
