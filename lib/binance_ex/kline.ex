defmodule BinanceEx.Kline do

  @doc """
  Aggregate trade.

  Binance response
  [
    [
      1499040000000,      // Open time
      "0.01634790",       // Open
      "0.80000000",       // High
      "0.01575800",       // Low
      "0.01577100",       // Close
      "148976.11427815",  // Volume
      1499644799999,      // Close time
      "2434.19055334",    // Quote asset volume
      308,                // Number of trades
      "1756.87402397",    // Taker buy base asset volume
      "28.46694368",      // Taker buy quote asset volume
      "17928899.62484339" // Ignore
    ]
  ]
  """

  defstruct [
    :open_time,
    :open,
    :high,
    :low,
    :close,
    :volume,
    :close_time,
    :quote_asset_volume,
    :no_of_trades,
    :taker_buy_base_asset_volume,
    :taker_buy_quote_asset_volume,
  ]

  def new(raw_data) do
    %BinanceEx.Kline{
      open_time: Enum.at(raw_data, 0),
      open: Enum.at(raw_data, 1) |> String.to_float,
      high: Enum.at(raw_data, 2) |> String.to_float,
      low: Enum.at(raw_data, 3) |> String.to_float,
      close: Enum.at(raw_data, 4) |> String.to_float,
      volume: Enum.at(raw_data, 5) |> String.to_float,
      close_time: Enum.at(raw_data, 6),
      quote_asset_volume: Enum.at(raw_data, 7) |> String.to_float,
      no_of_trades: Enum.at(raw_data, 8),
      taker_buy_base_asset_volume: Enum.at(raw_data, 9) |> String.to_float,
      taker_buy_quote_asset_volume: Enum.at(raw_data, 10) |> String.to_float
    }
  end

end
