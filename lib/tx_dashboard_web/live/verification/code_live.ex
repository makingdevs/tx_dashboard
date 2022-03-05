defmodule TxDashboardWeb.Verification.CodeLive do
  use TxDashboardWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :digits, [])}
  end

  @impl true
  def handle_event("capture", %{"key" => _key, "value" => value}, socket) do
    digits = value |> String.split("")
    {:noreply, assign(socket, :digits, digits)}
  end

  @impl true
  def handle_event("a_digit", _params, socket) do
    {:noreply, socket}
  end
end
