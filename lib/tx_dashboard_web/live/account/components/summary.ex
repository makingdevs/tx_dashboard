defmodule TxDashboardWeb.Account.Components.Summary do
  use TxDashboardWeb, :live_component

  @impl true
  def mount(socket) do
    socket =
      socket
      |> assign(name: "", lastname: "", account: "")

    {:ok, socket}
  end

  @impl true
  def update(
        %{account: %{"name" => name, "lastname" => lastname, "account" => account}} = _assigns,
        socket
      ) do
    socket =
      socket
      |> assign(
        name: String.capitalize(name),
        lastname: String.capitalize(lastname),
        account: account
      )

    {:ok, socket}
  end

  def update(_assigns, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("some-event", _params, socket) do
    IO.inspect(binding(), label: "SOME_EVENT")
    {:noreply, socket}
  end
end
