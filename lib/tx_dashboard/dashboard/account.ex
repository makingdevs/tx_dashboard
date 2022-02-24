defmodule TxDashboard.Dashboard.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias TxDashboard.Dashboard.Transaction

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
end
