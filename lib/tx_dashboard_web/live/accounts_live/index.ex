defmodule TxDashboardWeb.AccountsLive.Index do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard
  alias TxDashboard.Dashboard.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :accounts_collection, list_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Accounts")
    |> assign(:accounts, Dashboard.get_accounts!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Accounts")
    |> assign(:accounts, %Accounts{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Accounts")
    |> assign(:accounts, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    accounts = Dashboard.get_accounts!(id)
    {:ok, _} = Dashboard.delete_accounts(accounts)

    {:noreply, assign(socket, :accounts_collection, list_accounts())}
  end

  defp list_accounts do
    Dashboard.list_accounts()
  end
end
