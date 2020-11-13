defmodule CoreaWeb.SupulBalanceSheetLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.SupulBalanceSheets

  @create_attrs %{monetary_unit: "some monetary_unit"}
  @update_attrs %{monetary_unit: "some updated monetary_unit"}
  @invalid_attrs %{monetary_unit: nil}

  defp fixture(:supul_balance_sheet) do
    {:ok, supul_balance_sheet} = SupulBalanceSheets.create_supul_balance_sheet(@create_attrs)
    supul_balance_sheet
  end

  defp create_supul_balance_sheet(_) do
    supul_balance_sheet = fixture(:supul_balance_sheet)
    %{supul_balance_sheet: supul_balance_sheet}
  end

  describe "Index" do
    setup [:create_supul_balance_sheet]

    test "lists all supul_balance_sheets", %{conn: conn, supul_balance_sheet: supul_balance_sheet} do
      {:ok, _index_live, html} = live(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert html =~ "Listing Supul balance sheets"
      assert html =~ supul_balance_sheet.monetary_unit
    end

    test "saves new supul_balance_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert index_live |> element("a", "New Supul balance sheet") |> render_click() =~
               "New Supul balance sheet"

      assert_patch(index_live, Routes.supul_balance_sheet_index_path(conn, :new))

      assert index_live
             |> form("#supul_balance_sheet-form", supul_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supul_balance_sheet-form", supul_balance_sheet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert html =~ "Supul balance sheet created successfully"
      assert html =~ "some monetary_unit"
    end

    test "updates supul_balance_sheet in listing", %{conn: conn, supul_balance_sheet: supul_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#supul_balance_sheet-#{supul_balance_sheet.id} a", "Edit") |> render_click() =~
               "Edit Supul balance sheet"

      assert_patch(index_live, Routes.supul_balance_sheet_index_path(conn, :edit, supul_balance_sheet))

      assert index_live
             |> form("#supul_balance_sheet-form", supul_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supul_balance_sheet-form", supul_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert html =~ "Supul balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end

    test "deletes supul_balance_sheet in listing", %{conn: conn, supul_balance_sheet: supul_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.supul_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#supul_balance_sheet-#{supul_balance_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#supul_balance_sheet-#{supul_balance_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_supul_balance_sheet]

    test "displays supul_balance_sheet", %{conn: conn, supul_balance_sheet: supul_balance_sheet} do
      {:ok, _show_live, html} = live(conn, Routes.supul_balance_sheet_show_path(conn, :show, supul_balance_sheet))

      assert html =~ "Show Supul balance sheet"
      assert html =~ supul_balance_sheet.monetary_unit
    end

    test "updates supul_balance_sheet within modal", %{conn: conn, supul_balance_sheet: supul_balance_sheet} do
      {:ok, show_live, _html} = live(conn, Routes.supul_balance_sheet_show_path(conn, :show, supul_balance_sheet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Supul balance sheet"

      assert_patch(show_live, Routes.supul_balance_sheet_show_path(conn, :edit, supul_balance_sheet))

      assert show_live
             |> form("#supul_balance_sheet-form", supul_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#supul_balance_sheet-form", supul_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supul_balance_sheet_show_path(conn, :show, supul_balance_sheet))

      assert html =~ "Supul balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end
  end
end
