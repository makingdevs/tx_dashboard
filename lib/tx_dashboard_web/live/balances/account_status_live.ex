defmodule TxDashboardWeb.Balances.AccountStatusLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard
  alias TxDashboard.Dashboard.Transaction

  @topic "transactions"

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    Phoenix.PubSub.subscribe(TxDashboard.PubSub, @topic <> ":" <> account_number)
    transactions = Dashboard.list_transactions()
    {:ok, assign(socket, account_number: account_number, transactions: transactions)}
  end

  # def handle_params() do
  # end

  # def handle_event() do
  # end

  @impl true
  def handle_info(%Transaction{} = transaction, socket) do
    socket =
      socket
      |> update(:transactions, &[transaction | &1])

    {:noreply, socket}
  end
end
