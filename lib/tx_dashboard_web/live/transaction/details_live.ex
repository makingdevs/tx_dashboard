defmodule TxDashboardWeb.Transaction.DetailsLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:uploaded_files, [])
      |> allow_upload(:document, accept: ~w/.jpg .png/, max_entries: 3)

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:transaction, Dashboard.get_transaction!(id))

    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    socket = cancel_upload(socket, :document, ref)
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :document, fn %{path: path}, _entry ->
        {:ok, path}
      end)
      |> IO.inspect(label: "FILES")

    socket = update(socket, :uploaded_files, &(&1 ++ uploaded_files))
    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Transaction"
  defp page_title(:edit), do: "Edit Transaction"

  def error_to_string(:too_large), do: "Too large"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  def error_to_string(:too_many_files), do: "You have selected too many files"
end
