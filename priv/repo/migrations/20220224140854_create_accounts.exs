defmodule TxDashboard.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:lastname, :string)
      add(:account, :string)

      timestamps()
    end
  end
end
