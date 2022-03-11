defmodule TxDashboardWeb.Balances.AccountStatusLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard
  alias TxDashboard.Dashboard.Transaction

  @topic "transactions"
  @size_pages [5, 10, 15]

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    Phoenix.PubSub.subscribe(TxDashboard.PubSub, @topic <> ":" <> account_number)

    %{entries: transactions} = page = Dashboard.list_transactions_by_account(account_number)

    socket =
      socket
      |> assign(
        account_number: account_number,
        transactions: transactions,
        page: page,
        size_pages: @size_pages
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"page_size" => page_size} = _params, _uri, socket) do
    %{entries: transactions} =
      Dashboard.list_transactions_by_account(socket.assigns.account_number, page_size: page_size)

    socket =
      socket
      |> assign(:transactions, transactions)

    {:noreply, socket}
  end

  def handle_params(params, uri, socket) do
    params
    |> Map.put("page_size", 5)
    |> handle_params(uri, socket)
  end

  @impl true
  def handle_event("page_number", %{"page-number" => page_number}, socket) do
    IO.inspect(page_number)
    {:noreply, socket}
  end

  @impl true
  def handle_info(%Transaction{} = transaction, socket) do
    socket =
      socket
      |> update(:transactions, &[transaction | &1])

    {:noreply, socket}
  end
end
