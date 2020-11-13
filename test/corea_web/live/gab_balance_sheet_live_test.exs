defmodule CoreaWeb.GABBalanceSheetLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GABBalanceSheets

  @create_attrs %{t1: "120.5"}
  @update_attrs %{t1: "456.7"}
  @invalid_attrs %{t1: nil}

  defp fixture(:gab_balance_sheet) do
    {:ok, gab_balance_sheet} = GABBalanceSheets.create_gab_balance_sheet(@create_attrs)
    gab_balance_sheet
  end

  defp create_gab_balance_sheet(_) do
    gab_balance_sheet = fixture(:gab_balance_sheet)
    %{gab_balance_sheet: gab_balance_sheet}
  end

  describe "Index" do
    setup [:create_gab_balance_sheet]

    test "lists all gab_balance_sheets", %{conn: conn, gab_balance_sheet: gab_balance_sheet} do
      {:ok, _index_live, html} = live(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert html =~ "Listing Gab balance sheets"
    end

    test "saves new gab_balance_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert index_live |> element("a", "New Gab balance sheet") |> render_click() =~
               "New Gab balance sheet"

      assert_patch(index_live, Routes.gab_balance_sheet_index_path(conn, :new))

      assert index_live
             |> form("#gab_balance_sheet-form", gab_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab_balance_sheet-form", gab_balance_sheet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert html =~ "Gab balance sheet created successfully"
    end

    test "updates gab_balance_sheet in listing", %{conn: conn, gab_balance_sheet: gab_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gab_balance_sheet-#{gab_balance_sheet.id} a", "Edit") |> render_click() =~
               "Edit Gab balance sheet"

      assert_patch(index_live, Routes.gab_balance_sheet_index_path(conn, :edit, gab_balance_sheet))

      assert index_live
             |> form("#gab_balance_sheet-form", gab_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gab_balance_sheet-form", gab_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert html =~ "Gab balance sheet updated successfully"
    end

    test "deletes gab_balance_sheet in listing", %{conn: conn, gab_balance_sheet: gab_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gab_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gab_balance_sheet-#{gab_balance_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gab_balance_sheet-#{gab_balance_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_gab_balance_sheet]

    test "displays gab_balance_sheet", %{conn: conn, gab_balance_sheet: gab_balance_sheet} do
      {:ok, _show_live, html} = live(conn, Routes.gab_balance_sheet_show_path(conn, :show, gab_balance_sheet))

      assert html =~ "Show Gab balance sheet"
    end

    test "updates gab_balance_sheet within modal", %{conn: conn, gab_balance_sheet: gab_balance_sheet} do
      {:ok, show_live, _html} = live(conn, Routes.gab_balance_sheet_show_path(conn, :show, gab_balance_sheet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gab balance sheet"

      assert_patch(show_live, Routes.gab_balance_sheet_show_path(conn, :edit, gab_balance_sheet))

      assert show_live
             |> form("#gab_balance_sheet-form", gab_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gab_balance_sheet-form", gab_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gab_balance_sheet_show_path(conn, :show, gab_balance_sheet))

      assert html =~ "Gab balance sheet updated successfully"
    end
  end
end
