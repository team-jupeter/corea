defmodule CoreaWeb.FinancialAccountLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.FinancialAccounts

  @create_attrs %{left: "some left"}
  @update_attrs %{left: "some updated left"}
  @invalid_attrs %{left: nil}

  defp fixture(:financial_account) do
    {:ok, financial_account} = FinancialAccounts.create_financial_account(@create_attrs)
    financial_account
  end

  defp create_financial_account(_) do
    financial_account = fixture(:financial_account)
    %{financial_account: financial_account}
  end

  describe "Index" do
    setup [:create_financial_account]

    test "lists all financial_accounts", %{conn: conn, financial_account: financial_account} do
      {:ok, _index_live, html} = live(conn, Routes.financial_account_index_path(conn, :index))

      assert html =~ "Listing Financial accounts"
      assert html =~ financial_account.left
    end

    test "saves new financial_account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.financial_account_index_path(conn, :index))

      assert index_live |> element("a", "New Financial account") |> render_click() =~
               "New Financial account"

      assert_patch(index_live, Routes.financial_account_index_path(conn, :new))

      assert index_live
             |> form("#financial_account-form", financial_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#financial_account-form", financial_account: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_account_index_path(conn, :index))

      assert html =~ "Financial account created successfully"
      assert html =~ "some left"
    end

    test "updates financial_account in listing", %{conn: conn, financial_account: financial_account} do
      {:ok, index_live, _html} = live(conn, Routes.financial_account_index_path(conn, :index))

      assert index_live |> element("#financial_account-#{financial_account.id} a", "Edit") |> render_click() =~
               "Edit Financial account"

      assert_patch(index_live, Routes.financial_account_index_path(conn, :edit, financial_account))

      assert index_live
             |> form("#financial_account-form", financial_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#financial_account-form", financial_account: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_account_index_path(conn, :index))

      assert html =~ "Financial account updated successfully"
      assert html =~ "some updated left"
    end

    test "deletes financial_account in listing", %{conn: conn, financial_account: financial_account} do
      {:ok, index_live, _html} = live(conn, Routes.financial_account_index_path(conn, :index))

      assert index_live |> element("#financial_account-#{financial_account.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#financial_account-#{financial_account.id}")
    end
  end

  describe "Show" do
    setup [:create_financial_account]

    test "displays financial_account", %{conn: conn, financial_account: financial_account} do
      {:ok, _show_live, html} = live(conn, Routes.financial_account_show_path(conn, :show, financial_account))

      assert html =~ "Show Financial account"
      assert html =~ financial_account.left
    end

    test "updates financial_account within modal", %{conn: conn, financial_account: financial_account} do
      {:ok, show_live, _html} = live(conn, Routes.financial_account_show_path(conn, :show, financial_account))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Financial account"

      assert_patch(show_live, Routes.financial_account_show_path(conn, :edit, financial_account))

      assert show_live
             |> form("#financial_account-form", financial_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#financial_account-form", financial_account: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_account_show_path(conn, :show, financial_account))

      assert html =~ "Financial account updated successfully"
      assert html =~ "some updated left"
    end
  end
end
