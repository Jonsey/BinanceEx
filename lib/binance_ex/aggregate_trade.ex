
defmodule BinanceEx.AggregateTrade do

  @doc """
  Aggregate trade.
  """
  defstruct [:a, :p, :q, :f, :l, :T, :m, :M]

  use ExConstructor

end
