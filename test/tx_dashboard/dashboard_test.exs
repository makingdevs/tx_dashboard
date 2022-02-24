defmodule TxDashboard.DashboardTest do
  use TxDashboard.DataCase

  alias TxDashboard.Dashboard

  describe "accounts" do
    alias TxDashboard.Dashboard.Account

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{account: nil, lastname: nil, name: nil}

    test "list_account/0 returns all account" do
      account = account_fixture()
      assert Dashboard.list_account() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Dashboard.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{account: "some account", lastname: "some lastname", name: "some name"}

      assert {:ok, %Account{} = account} = Dashboard.create_account(valid_attrs)
      assert account.account == "some account"
      assert account.lastname == "some lastname"
      assert account.name == "some name"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()

      update_attrs = %{
        account: "some updated account",
        lastname: "some updated lastname",
        name: "some updated name"
      }

      assert {:ok, %Account{} = account} = Dashboard.update_account(account, update_attrs)
      assert account.account == "some updated account"
      assert account.lastname == "some updated lastname"
      assert account.name == "some updated name"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_account(account, @invalid_attrs)
      assert account == Dashboard.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Dashboard.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_account(account)
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
      valid_attrs = %{
        amount: 120.5,
        concept: "some concept",
        currency: "some currency",
        origin: "some origin",
        type: "some type"
      }

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

      update_attrs = %{
        amount: 456.7,
        concept: "some updated concept",
        currency: "some updated currency",
        origin: "some updated origin",
        type: "some updated type"
      }

      assert {:ok, %Transaction{} = transaction} =
               Dashboard.update_transaction(transaction, update_attrs)

      assert transaction.amount == 456.7
      assert transaction.concept == "some updated concept"
      assert transaction.currency == "some updated currency"
      assert transaction.origin == "some updated origin"
      assert transaction.type == "some updated type"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Dashboard.update_transaction(transaction, @invalid_attrs)

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
