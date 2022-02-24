defmodule TxDashboard.Dashboard.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias TxDashboard.Dashboard.Accounts

  schema "transactions" do
    field :amount, :float
    field :concept, :string
    field :currency, :string
    field :origin, :string
    field :type, :string
    belongs_to :account, Accounts

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :origin, :concept, :amount, :currency, :account_id])
    |> validate_required([:type, :origin, :concept, :amount, :currency])
    |> foreign_key_constraint(:account_id, name: "transactions_account")
  end
end
