defmodule TxDashboardWeb.Account.NewCustomerLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard
  alias TxDashboard.Dashboard.Account

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(self(), label: __MODULE__)
    changeset = Dashboard.change_account(%Account{}, %{})
    {:ok, assign(socket, changeset: changeset, account: %{})}
  end

  @impl true
  def handle_event("validate", %{"account" => account}, socket) do
    changeset =
      Dashboard.change_account(%Account{}, account)
      |> Map.put(:action, :insert)

    socket =
      socket
      |> assign(
        changeset: changeset,
        account: account
      )

    socket =
      socket
      |> assign(changeset: changeset)

    {:noreply, socket}
  end

  @impl true
  def handle_event("save", %{"account" => _account}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("generic_click", _params, socket) do
    send(self(), {"new_event", %{"account" => %{"name" => "Mr Process"}}})
    {:noreply, socket}
  end

  @impl true
  def handle_info({"new_event", %{"account" => account}}, state) do
    changeset =
      Dashboard.change_account(%Account{}, account)
      |> Map.put(:action, :insert)

    {:noreply, assign(state, changeset: changeset, account: account)}
  end
end
