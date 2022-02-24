defmodule TxDashboard.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :lastname, :string
      add :account, :string

      timestamps()
    end
  end
end
