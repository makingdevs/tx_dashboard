defmodule TxDashboard.Dashboard.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias TxDashboard.Dashboard.Transaction

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :account, :string
    field :lastname, :string
    field :name, :string
    has_many :transactions, Transaction

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :lastname, :account])
    |> validate_required([:name, :lastname, :account])
  end

  def find_by_account_number(account_number, query \\ __MODULE__) do
    from query, where: [account: ^account_number]
  end
end
