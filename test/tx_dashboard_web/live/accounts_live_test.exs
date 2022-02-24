defmodule TxDashboardWeb.AccountsLiveTest do
  use TxDashboardWeb.ConnCase

  import Phoenix.LiveViewTest
  import TxDashboard.DashboardFixtures

  @create_attrs %{account: "some account", lastname: "some lastname", name: "some name"}
  @update_attrs %{account: "some updated account", lastname: "some updated lastname", name: "some updated name"}
  @invalid_attrs %{account: nil, lastname: nil, name: nil}

  defp create_accounts(_) do
    accounts = accounts_fixture()
    %{accounts: accounts}
  end

  describe "Index" do
    setup [:create_accounts]

    test "lists all accounts", %{conn: conn, accounts: accounts} do
      {:ok, _index_live, html} = live(conn, Routes.accounts_index_path(conn, :index))

      assert html =~ "Listing Accounts"
      assert html =~ accounts.account
    end

    test "saves new accounts", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.accounts_index_path(conn, :index))

      assert index_live |> element("a", "New Accounts") |> render_click() =~
               "New Accounts"

      assert_patch(index_live, Routes.accounts_index_path(conn, :new))

      assert index_live
             |> form("#accounts-form", accounts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#accounts-form", accounts: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.accounts_index_path(conn, :index))

      assert html =~ "Accounts created successfully"
      assert html =~ "some account"
    end

    test "updates accounts in listing", %{conn: conn, accounts: accounts} do
      {:ok, index_live, _html} = live(conn, Routes.accounts_index_path(conn, :index))

      assert index_live |> element("#accounts-#{accounts.id} a", "Edit") |> render_click() =~
               "Edit Accounts"

      assert_patch(index_live, Routes.accounts_index_path(conn, :edit, accounts))

      assert index_live
             |> form("#accounts-form", accounts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#accounts-form", accounts: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.accounts_index_path(conn, :index))

      assert html =~ "Accounts updated successfully"
      assert html =~ "some updated account"
    end

    test "deletes accounts in listing", %{conn: conn, accounts: accounts} do
      {:ok, index_live, _html} = live(conn, Routes.accounts_index_path(conn, :index))

      assert index_live |> element("#accounts-#{accounts.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#accounts-#{accounts.id}")
    end
  end

  describe "Show" do
    setup [:create_accounts]

    test "displays accounts", %{conn: conn, accounts: accounts} do
      {:ok, _show_live, html} = live(conn, Routes.accounts_show_path(conn, :show, accounts))

      assert html =~ "Show Accounts"
      assert html =~ accounts.account
    end

    test "updates accounts within modal", %{conn: conn, accounts: accounts} do
      {:ok, show_live, _html} = live(conn, Routes.accounts_show_path(conn, :show, accounts))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Accounts"

      assert_patch(show_live, Routes.accounts_show_path(conn, :edit, accounts))

      assert show_live
             |> form("#accounts-form", accounts: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#accounts-form", accounts: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.accounts_show_path(conn, :show, accounts))

      assert html =~ "Accounts updated successfully"
      assert html =~ "some updated account"
    end
  end
end
