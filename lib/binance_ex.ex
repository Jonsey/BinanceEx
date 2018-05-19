defmodule BinanceEx do
  require HTTPoison

  @base_url "https://api.binance.com"

  @moduledoc """
  Documentation for BinanceEx.
  """

  @doc """
  Ping the binance server.

  ## Examples

      iex> BinanceEx.ping()
      {:ok, %{}}

  """
  def ping() do
    get("/api/v1/ping")
  end

  @doc """
  Get the market depth for a specified symbol.
  symbol is mandatory
  limit Default 100; max 1000. Valid limits:[5, 10, 20, 50, 100, 500, 1000]

  returns
      {:ok,
            %BinanceEx.Orderbook{
              asks: [
                ["0.01627700", "18.30000000", []],
                ["0.01627800", "13.78000000", []],
                ["0.01627900", "0.90000000", []],
                ["0.01628000", "54.70000000", []],
                ["0.01628400", "0.60000000", []]
              ],
              bids: [
                ["0.01624600", "1.03000000", []],
                ["0.01624500", "7.12000000", []],
                ["0.01624100", "1.23000000", []],
                ["0.01624000", "0.07000000", []],
                ["0.01623900", "0.82000000", []]
              ],
              last_update_id: 76432934
            }}

  """
  def get_depth(symbol, limit)
      when limit in [5, 10, 20, 50, 100, 500, 1000] do
    do_get_depth %{symbol: symbol, limit: limit}
  end

  def get_depth(_symbol, _limit) do
    {:err, %{
        msg: "Illegal characters found in parameter 'interval'; legal range is '5, 10, 20, 50, 100, 500, 1000'."
      }
    }
  end

  def get_depth(symbol) do
    do_get_depth %{symbol: symbol}
  end

  defp do_get_depth(params) do
    case get("/api/v1/depth", params) do
      {:ok, orderbook} -> {:ok, BinanceEx.Orderbook.new(orderbook)}
      err -> err
    end
  end

  @doc """
  Get binance exchange information.

  """
  def get_exchange_info() do
    case get("/api/v1/exchangeInfo") do
      {:ok, exchange_info} -> {:ok, BinanceEx.ExchangeInfo.new(exchange_info)}
      err -> err
    end
  end

  @doc """
  Get recent trade history.

  """
  def recent_trades(symbol, limit) do
    params = %{symbol: symbol, limit: limit}

    case get("/api/v1/trades", params) do
      {:ok, recent_trades} ->
        {:ok, Enum.map(recent_trades, fn(x) -> BinanceEx.Trade.new(x) end)}
      err -> err
    end
  end

  @doc """
  Get recent trade history.

  """
  def historical_trades(symbol, limit) do
    params = %{symbol: symbol, limit: limit}

    case get_with_key("/api/v1/historicalTrades", params) do
      {:ok, historical_trades} ->
        {:ok, Enum.map(historical_trades, fn(x) -> BinanceEx.Trade.new(x) end)}
      err -> err
    end
  end

  @doc """
  Get compressed, aggregate trades. Trades that fill at the time, from the same order, with the same price will have the quantity aggregated.

  """
  def aggregate_trades(symbol) do
    params = %{symbol: symbol}

    case get_with_key("/api/v1/aggTrades", params) do
      {:ok, aggregate_trades} ->
        {:ok, Enum.map(aggregate_trades, fn(x) -> BinanceEx.AggregateTrade.new(x) end)}
      err -> err
    end
  end

  @doc """
  Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.
  https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md#klinecandlestick-data

  """
  def klines(symbol, interval) do
    params = %{symbol: symbol, interval: interval}

    case get("/api/v1/klines", params) do
      {:ok, klines} ->
        {:ok, Enum.map(klines, fn(x) -> BinanceEx.Kline.new(x) end)}
      err -> err
    end
  end


  defp get(url) do
    HTTPoison.get("#{@base_url}#{url}")
    |> parse_response
  end

  defp get(url, params) do
    argument_string = URI.encode_query(params)

    HTTPoison.get("#{@base_url}#{url}?#{argument_string}")
    |> parse_response
  end

  defp get_with_key(url, params) do
    argument_string = URI.encode_query(params)
    headers = [{"X-MBX-APIKEY", Application.get_env(:binance_ex, :api_key)}]

    HTTPoison.get("#{@base_url}#{url}?#{argument_string}", headers)
    |> parse_response
  end

  defp parse_response({:ok, response}) do
    response.body
    |> Poison.decode()
    |> parse_response_body
  end

  defp parse_response_body({:ok, data}) do
    {:ok, data}
  end
end
