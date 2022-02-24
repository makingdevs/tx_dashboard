defmodule TxDashboard.Dashboard.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :float
    field :concept, :string
    field :currency, :string
    field :origin, :string
    field :type, :string
    field :account_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :origin, :concept, :amount, :currency])
    |> validate_required([:type, :origin, :concept, :amount, :currency])
  end
end
