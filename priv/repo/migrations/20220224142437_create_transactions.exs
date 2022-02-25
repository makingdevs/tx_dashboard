defmodule TxDashboard.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:type, :string)
      add(:origin, :string)
      add(:concept, :string)
      add(:amount, :float)
      add(:currency, :string)
      add(:account_id, references(:accounts, on_delete: :nothing, type: :binary_id), null: false)

      timestamps()
    end

    create(index(:transactions, [:account_id]))
  end
end
