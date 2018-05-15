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
      response = BinanceEx.get_depth("ETCBTC", 5)

      case response do
        {:ok, orderbook} ->
          assert length(orderbook.asks) == 5
          assert length(orderbook.bids) == 5
      end
    end
  end

  test "should return market depth of 100 when no limit specified" do
    use_cassette "market_depth_default" do
      response = BinanceEx.get_depth("ETCBTC")

      case response do
        {:ok, orderbook} ->
          assert length(orderbook.asks) == 100
          assert length(orderbook.bids) == 100
      end
    end
  end

  # valid limits [5, 10, 20, 50, 100, 500, 1000]
  test "should return error if invalid limit selected" do
    use_cassette "market_depth_invalid_limit" do
      response = BinanceEx.get_depth("ETCBTC", 1)

      case response do
        {:err, err} ->
          assert err.msg == "Illegal characters found in parameter 'interval'; legal range is '5, 10, 20, 50, 100, 500, 1000'."
      end
    end
  end

  test "should return exchange info" do
    use_cassette "exchange_info" do
      response = BinanceEx.get_exchange_info()

      case response do
        {:ok, exchange_info} ->
          assert length(exchange_info.symbols) > 0
        _ -> assert false
      end
    end
  end

  test "should return list of recent trades" do
    use_cassette "recent_trades" do
      response = BinanceEx.recent_trades("ETCBTC", 2)

      case response do
        {:ok, recent_trades} ->
          assert length(recent_trades) == 2
        _ -> assert false
      end
    end
  end

  test "should return list of historic trades" do
    use_cassette "historical_trades" do
      response = BinanceEx.historical_trades("ETCBTC", 2)

      case response do
        {:ok, historical_trades} ->
          assert length(historical_trades) == 2
        _ -> assert false
      end
    end
  end

  test "Should return default amount of aggregate trades" do
    use_cassette "aggregate_trades" do
      response = BinanceEx.aggregate_trades("ETCBTC")

      case response do
        {:ok, aggregate_trades} ->
          assert length(aggregate_trades) == 500
          first_item = List.first(aggregate_trades)
          assert first_item.a != nil
        _ -> assert false
      end
    end
  end
end
