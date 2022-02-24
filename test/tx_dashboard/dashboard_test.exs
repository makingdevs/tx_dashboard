defmodule TxDashboard.DashboardTest do
  use TxDashboard.DataCase

  alias TxDashboard.Dashboard

  describe "accounts" do
    alias TxDashboard.Dashboard.Accounts

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{account: nil, lastname: nil, name: nil}

    test "list_accounts/0 returns all accounts" do
      accounts = accounts_fixture()
      assert Dashboard.list_accounts() == [accounts]
    end

    test "get_accounts!/1 returns the accounts with given id" do
      accounts = accounts_fixture()
      assert Dashboard.get_accounts!(accounts.id) == accounts
    end

    test "create_accounts/1 with valid data creates a accounts" do
      valid_attrs = %{account: "some account", lastname: "some lastname", name: "some name"}

      assert {:ok, %Accounts{} = accounts} = Dashboard.create_accounts(valid_attrs)
      assert accounts.account == "some account"
      assert accounts.lastname == "some lastname"
      assert accounts.name == "some name"
    end

    test "create_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_accounts(@invalid_attrs)
    end

    test "update_accounts/2 with valid data updates the accounts" do
      accounts = accounts_fixture()
      update_attrs = %{account: "some updated account", lastname: "some updated lastname", name: "some updated name"}

      assert {:ok, %Accounts{} = accounts} = Dashboard.update_accounts(accounts, update_attrs)
      assert accounts.account == "some updated account"
      assert accounts.lastname == "some updated lastname"
      assert accounts.name == "some updated name"
    end

    test "update_accounts/2 with invalid data returns error changeset" do
      accounts = accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_accounts(accounts, @invalid_attrs)
      assert accounts == Dashboard.get_accounts!(accounts.id)
    end

    test "delete_accounts/1 deletes the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Accounts{}} = Dashboard.delete_accounts(accounts)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_accounts!(accounts.id) end
    end

    test "change_accounts/1 returns a accounts changeset" do
      accounts = accounts_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_accounts(accounts)
    end
  end

  describe "transactions" do
    alias TxDashboard.Dashboard.Transaction

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{amount: nil, concept: nil, currency: nil, origin: nil, type: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Dashboard.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Dashboard.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{amount: 120.5, concept: "some concept", currency: "some currency", origin: "some origin", type: "some type"}

      assert {:ok, %Transaction{} = transaction} = Dashboard.create_transaction(valid_attrs)
      assert transaction.amount == 120.5
      assert transaction.concept == "some concept"
      assert transaction.currency == "some currency"
      assert transaction.origin == "some origin"
      assert transaction.type == "some type"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{amount: 456.7, concept: "some updated concept", currency: "some updated currency", origin: "some updated origin", type: "some updated type"}

      assert {:ok, %Transaction{} = transaction} = Dashboard.update_transaction(transaction, update_attrs)
      assert transaction.amount == 456.7
      assert transaction.concept == "some updated concept"
      assert transaction.currency == "some updated currency"
      assert transaction.origin == "some updated origin"
      assert transaction.type == "some updated type"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_transaction(transaction, @invalid_attrs)
      assert transaction == Dashboard.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Dashboard.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_transaction(transaction)
    end
  end
end
