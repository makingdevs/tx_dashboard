defmodule TxDashboardWeb.AccountsLive.FormComponent do
  use TxDashboardWeb, :live_component

  alias TxDashboard.Dashboard

  @impl true
  def update(%{accounts: accounts} = assigns, socket) do
    changeset = Dashboard.change_accounts(accounts)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"accounts" => accounts_params}, socket) do
    changeset =
      socket.assigns.accounts
      |> Dashboard.change_accounts(accounts_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"accounts" => accounts_params}, socket) do
    save_accounts(socket, socket.assigns.action, accounts_params)
  end

  defp save_accounts(socket, :edit, accounts_params) do
    case Dashboard.update_accounts(socket.assigns.accounts, accounts_params) do
      {:ok, _accounts} ->
        {:noreply,
         socket
         |> put_flash(:info, "Accounts updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_accounts(socket, :new, accounts_params) do
    case Dashboard.create_accounts(accounts_params) do
      {:ok, _accounts} ->
        {:noreply,
         socket
         |> put_flash(:info, "Accounts created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
