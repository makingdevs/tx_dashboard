defmodule TxDashboard.TxWrapper do
  @doc """
  Receive a String from msg of rabbit, and transform into a map
  """
  @spec wrap(String.t()) :: map()
  def wrap(json_encoded) do
    Jason.decode!(json_encoded)
    |> IO.inspect()
  end
end
