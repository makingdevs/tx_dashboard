defmodule TxDashboard.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  alias TxDashboard.Repo
  alias TxDashboard.Dashboard.Account
  alias TxDashboard.Dashboard.Transaction

  @type page_spec :: %{
          entries: [%Transaction{}, ...],
          page_number: integer(),
          page_size: integer(),
          total_pages: integer(),
          total_entries: integer()
        }

  @topic "transactions"

  @doc """
  Returns the list of account.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    Repo.all(Account)
  end

  @doc """
  Gets a single account.

  Raises `Ecto.NoResultsError` if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account!(id), do: Repo.get!(Account, id)

  @doc """
  Creates a account.

  ## Examples

      iex> create_account(%{field: value})
      {:ok, %Account{}}

      iex> create_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account.

  ## Examples

      iex> update_account(account, %{field: new_value})
      {:ok, %Account{}}

      iex> update_account(account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a account.

  ## Examples

      iex> delete_account(account)
      {:ok, %Account{}}

      iex> delete_account(account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account changes.

  ## Examples

      iex> change_account(account)
      %Ecto.Changeset{data: %Account{}}

  """
  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Return a list of transactions for account number

  ## Examples

      iex> list_transactions_by_account("12345678")
      %{entries: 1, page_number: 1, page_size: 1, total_pages: 1, total_entries: [%Transaction{}]}

  """
  # @spec list_transactions_by_account(integer() | String.t()) :: [%Transaction{}, ...]
  @spec list_transactions_by_account(integer() | String.t()) :: page_spec()
  # @spec list_transactions_by_account(integer() | String.t()) :: map()
  def list_transactions_by_account(account_number) do
    page =
      account_number
      |> Transaction.transactions_for_account()
      |> Repo.paginate(page_size: 5)

    %{
      entries: page.entries,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
    }
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  @doc """
    account_number - String.t()
    |> Ecto.Query
    |> TxDashboard.Dashboard.Account
    |> TxDashboard.Dashboard.Transaction w/ID Account
    |> Changeset Transaction
    |> Insert -> Transaction
  """
  def apply_transaction(%{"account" => account_number} = params) do
    account_number
    |> Account.find_by_account_number()
    |> Repo.one!()
    |> Transaction.for_account()
    |> change_transaction(params)
    |> Repo.insert!()
    |> push_tx(account_number)
  end

  defp push_tx(%Transaction{} = transaction, account_number) do
    Phoenix.PubSub.broadcast(TxDashboard.PubSub, @topic <> ":" <> account_number, transaction)
  end
end
