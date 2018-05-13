defmodule BinanceExTest do
  use ExUnit.Case
  doctest BinanceEx

  test "ping returns an empty map" do
    assert BinanceEx.ping() == {:ok, %{}} 
  end
end
