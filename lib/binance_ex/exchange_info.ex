defmodule BinanceEx.ExchangeInfo do
  defstruct [:timezone, :servertime, :rateLimits, :exchangeFilters, :symbols]

  use ExConstructor
end
