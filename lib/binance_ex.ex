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
    HTTPoison.get('#{@base_url}/api/v1/ping')
    |> parse_response
  end

  def get_depth(symbol, limit) do
    params = %{symbol: symbol, limit: limit}
    argument_string = URI.encode_query(params)

    response = HTTPoison.get("#{@base_url}/api/v1/depth?#{argument_string}")
    |> parse_response

    case response do
      {:ok, orderbook} -> {:ok, BinanceEx.Orderbook.new orderbook}
      err -> err
    end

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
