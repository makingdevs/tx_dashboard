defmodule TxDashboardWeb.Account.Components.Another do
  use TxDashboardWeb, :live_component

  @impl true
  def mount(socket) do
    IO.inspect(self(), label: __MODULE__)
    {:ok, socket}
  end

  @impl true
  def handle_event("some-event", _params, socket) do
    IO.inspect(binding(), label: "SOME_EVENT_ANOTHER")
    {:noreply, socket}
  end
end
