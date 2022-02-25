defmodule TxDashboardWeb.BalancesLive.Index do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    transactions = Dashboard.list_transactions()
    {:ok, assign(socket, account_number: account_number, transactions: transactions)}
  end
end
