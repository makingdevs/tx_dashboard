defmodule TxDashboardWeb.Account.Components.Another do
  use TxDashboardWeb, :live_component

  @impl true
  def handle_event("some-event", _params, socket) do
    IO.inspect(binding(), label: "SOME_EVENT_ANOTHER")
    {:noreply, socket}
  end
end
