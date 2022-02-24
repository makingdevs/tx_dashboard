defmodule TxDashboard.DashboardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TxDashboard.Dashboard` context.
  """

  @doc """
  Generate a accounts.
  """
  def accounts_fixture(attrs \\ %{}) do
    {:ok, accounts} =
      attrs
      |> Enum.into(%{
        account: "some account",
        lastname: "some lastname",
        name: "some name"
      })
      |> TxDashboard.Dashboard.create_accounts()

    accounts
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        concept: "some concept",
        currency: "some currency",
        origin: "some origin",
        type: "some type"
      })
      |> TxDashboard.Dashboard.create_transaction()

    transaction
  end
end
