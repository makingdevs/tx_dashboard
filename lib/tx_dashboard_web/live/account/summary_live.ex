defmodule TxDashboardWeb.Account.SummaryLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:account, Dashboard.get_account!(id))

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Account"
  defp page_title(:edit), do: "Edit Account"
end
