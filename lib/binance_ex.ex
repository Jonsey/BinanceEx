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
    binance_get("/api/v1/ping")
  end

  def get_depth(symbol, limit) do
    params = %{symbol: symbol, limit: limit}

    case binance_get("/api/v1/depth", params) do
      {:ok, orderbook} -> {:ok, BinanceEx.Orderbook.new(orderbook)}
      err -> err
    end
  end

  defp binance_get(url) do
    HTTPoison.get("#{@base_url}#{url}")
    |> parse_response
  end

  defp binance_get(url, params) do
    argument_string = URI.encode_query(params)

    HTTPoison.get("#{@base_url}#{url}?#{argument_string}")
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
