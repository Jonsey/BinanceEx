defmodule BinanceExTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  require HTTPoison

  doctest BinanceEx



  test "ping returns an empty map" do
    use_cassette "ping" do
      assert BinanceEx.ping() == {:ok, %{}}
    end
  end

  test "should return market depth" do
    use_cassette "market_depth" do
      response = BinanceEx.get_depth("ETCBTC", 10)
      case response do
        {:ok, orderbook} ->
          assert length(orderbook.asks) == 10
          assert length(orderbook.bids) == 10
      end
    end
  end


end
