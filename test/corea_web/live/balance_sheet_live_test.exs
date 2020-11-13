defmodule CoreaWeb.BalanceSheetLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.BalanceSheets

  @create_attrs %{entity_name: "some entity_name"}
  @update_attrs %{entity_name: "some updated entity_name"}
  @invalid_attrs %{entity_name: nil}

  defp fixture(:balance_sheet) do
    {:ok, balance_sheet} = BalanceSheets.create_balance_sheet(@create_attrs)
    balance_sheet
  end

  defp create_balance_sheet(_) do
    balance_sheet = fixture(:balance_sheet)
    %{balance_sheet: balance_sheet}
  end

  describe "Index" do
    setup [:create_balance_sheet]

    test "lists all balance_sheets", %{conn: conn, balance_sheet: balance_sheet} do
      {:ok, _index_live, html} = live(conn, Routes.balance_sheet_index_path(conn, :index))

      assert html =~ "Listing Balance sheets"
      assert html =~ balance_sheet.entity_name
    end

    test "saves new balance_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.balance_sheet_index_path(conn, :index))

      assert index_live |> element("a", "New Balance sheet") |> render_click() =~
               "New Balance sheet"

      assert_patch(index_live, Routes.balance_sheet_index_path(conn, :new))

      assert index_live
             |> form("#balance_sheet-form", balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#balance_sheet-form", balance_sheet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.balance_sheet_index_path(conn, :index))

      assert html =~ "Balance sheet created successfully"
      assert html =~ "some entity_name"
    end

    test "updates balance_sheet in listing", %{conn: conn, balance_sheet: balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.balance_sheet_index_path(conn, :index))

      assert index_live |> element("#balance_sheet-#{balance_sheet.id} a", "Edit") |> render_click() =~
               "Edit Balance sheet"

      assert_patch(index_live, Routes.balance_sheet_index_path(conn, :edit, balance_sheet))

      assert index_live
             |> form("#balance_sheet-form", balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#balance_sheet-form", balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.balance_sheet_index_path(conn, :index))

      assert html =~ "Balance sheet updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes balance_sheet in listing", %{conn: conn, balance_sheet: balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.balance_sheet_index_path(conn, :index))

      assert index_live |> element("#balance_sheet-#{balance_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#balance_sheet-#{balance_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_balance_sheet]

    test "displays balance_sheet", %{conn: conn, balance_sheet: balance_sheet} do
      {:ok, _show_live, html} = live(conn, Routes.balance_sheet_show_path(conn, :show, balance_sheet))

      assert html =~ "Show Balance sheet"
      assert html =~ balance_sheet.entity_name
    end

    test "updates balance_sheet within modal", %{conn: conn, balance_sheet: balance_sheet} do
      {:ok, show_live, _html} = live(conn, Routes.balance_sheet_show_path(conn, :show, balance_sheet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Balance sheet"

      assert_patch(show_live, Routes.balance_sheet_show_path(conn, :edit, balance_sheet))

      assert show_live
             |> form("#balance_sheet-form", balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#balance_sheet-form", balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.balance_sheet_show_path(conn, :show, balance_sheet))

      assert html =~ "Balance sheet updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end
