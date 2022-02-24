defmodule TxDashboard.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :type, :string
      add :origin, :string
      add :concept, :string
      add :amount, :float
      add :currency, :string
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:account_id])
  end
end
