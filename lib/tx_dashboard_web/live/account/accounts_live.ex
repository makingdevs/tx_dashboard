defmodule TxDashboardWeb.Account.AccountsLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard
  alias TxDashboard.Dashboard.Account

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :account_collection, list_account())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Account")
    |> assign(:account, Dashboard.get_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account")
    |> assign(:account, %Account{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Account")
    |> assign(:account, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    account = Dashboard.get_account!(id)
    {:ok, _} = Dashboard.delete_account(account)

    {:noreply, assign(socket, :account_collection, list_account())}
  end

  defp list_account do
    Dashboard.list_accounts()
  end
end
