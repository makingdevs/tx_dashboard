defmodule TxDashboard.Dashboard.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias TxDashboard.Dashboard.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :amount, :float
    field :concept, :string
    field :currency, :string
    field :origin, :string
    field :type, :string
    belongs_to :account, Account

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :origin, :concept, :amount, :currency, :account_id])
    |> validate_required([:type, :origin, :concept, :amount, :currency, :account_id])
    |> foreign_key_constraint(:account_id)
  end

  def for_account(%Account{} = account, params \\ %{}) do
    account
    |> Ecto.build_assoc(:transactions, params)
  end
end
