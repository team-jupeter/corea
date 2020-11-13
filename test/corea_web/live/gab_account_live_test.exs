defmodule CoreaWeb.GABAccountLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GABAccounts

  @create_attrs %{entity_name: "some entity_name"}
  @update_attrs %{entity_name: "some updated entity_name"}
  @invalid_attrs %{entity_name: nil}

  defp fixture(:gab_account) do
    {:ok, gab_account} = GABAccounts.create_gab_account(@create_attrs)
    gab_account
  end

  defp create_gab_account(_) do
    gab_account = fixture(:gab_account)
    %{gab_account: gab_account}
  end

  describe "Index" do
    setup [:create_gab_account]

    test "lists all gab_accounts", %{conn: conn, gab_account: gab_account} do
      {:ok, _index_live, html} = live(conn, Routes.gab_account_index_path(conn, :index))

      assert html =~ "Listing Gab accounts"
      assert html =~ gab_account.entity_name
    end

    test "saves new gab_account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gab_account_index_path(conn, :index))

      assert index_live |> element("a", "New Gab account") |> render_click() =~
               "New Gab account"

      assert_patch(index_live, Routes.gab_account_index_path(conn, :new))

      assert index_live
             |> form("#gab_account-form", gab_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab_account-form", gab_account: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_account_index_path(conn, :index))

      assert html =~ "Gab account created successfully"
      assert html =~ "some entity_name"
    end

    test "updates gab_account in listing", %{conn: conn, gab_account: gab_account} do
      {:ok, index_live, _html} = live(conn, Routes.gab_account_index_path(conn, :index))

      assert index_live |> element("#gab_account-#{gab_account.id} a", "Edit") |> render_click() =~
               "Edit Gab account"

      assert_patch(index_live, Routes.gab_account_index_path(conn, :edit, gab_account))

      assert index_live
             |> form("#gab_account-form", gab_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab_account-form", gab_account: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_account_index_path(conn, :index))

      assert html =~ "Gab account updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes gab_account in listing", %{conn: conn, gab_account: gab_account} do
      {:ok, index_live, _html} = live(conn, Routes.gab_account_index_path(conn, :index))

      assert index_live |> element("#gab_account-#{gab_account.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gab_account-#{gab_account.id}")
    end
  end

  describe "Show" do
    setup [:create_gab_account]

    test "displays gab_account", %{conn: conn, gab_account: gab_account} do
      {:ok, _show_live, html} = live(conn, Routes.gab_account_show_path(conn, :show, gab_account))

      assert html =~ "Show Gab account"
      assert html =~ gab_account.entity_name
    end

    test "updates gab_account within modal", %{conn: conn, gab_account: gab_account} do
      {:ok, show_live, _html} = live(conn, Routes.gab_account_show_path(conn, :show, gab_account))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gab account"

      assert_patch(show_live, Routes.gab_account_show_path(conn, :edit, gab_account))

      assert show_live
             |> form("#gab_account-form", gab_account: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gab_account-form", gab_account: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_account_show_path(conn, :show, gab_account))

      assert html =~ "Gab account updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end
