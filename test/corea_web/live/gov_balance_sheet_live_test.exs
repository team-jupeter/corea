defmodule CoreaWeb.GovBalanceSheetLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GovBalanceSheets

  @create_attrs %{monetary_unit: "some monetary_unit"}
  @update_attrs %{monetary_unit: "some updated monetary_unit"}
  @invalid_attrs %{monetary_unit: nil}

  defp fixture(:gov_balance_sheet) do
    {:ok, gov_balance_sheet} = GovBalanceSheets.create_gov_balance_sheet(@create_attrs)
    gov_balance_sheet
  end

  defp create_gov_balance_sheet(_) do
    gov_balance_sheet = fixture(:gov_balance_sheet)
    %{gov_balance_sheet: gov_balance_sheet}
  end

  describe "Index" do
    setup [:create_gov_balance_sheet]

    test "lists all gov_balance_sheets", %{conn: conn, gov_balance_sheet: gov_balance_sheet} do
      {:ok, _index_live, html} = live(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert html =~ "Listing Gov balance sheets"
      assert html =~ gov_balance_sheet.monetary_unit
    end

    test "saves new gov_balance_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert index_live |> element("a", "New Gov balance sheet") |> render_click() =~
               "New Gov balance sheet"

      assert_patch(index_live, Routes.gov_balance_sheet_index_path(conn, :new))

      assert index_live
             |> form("#gov_balance_sheet-form", gov_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gov_balance_sheet-form", gov_balance_sheet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert html =~ "Gov balance sheet created successfully"
      assert html =~ "some monetary_unit"
    end

    test "updates gov_balance_sheet in listing", %{conn: conn, gov_balance_sheet: gov_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gov_balance_sheet-#{gov_balance_sheet.id} a", "Edit") |> render_click() =~
               "Edit Gov balance sheet"

      assert_patch(index_live, Routes.gov_balance_sheet_index_path(conn, :edit, gov_balance_sheet))

      assert index_live
             |> form("#gov_balance_sheet-form", gov_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gov_balance_sheet-form", gov_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert html =~ "Gov balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end

    test "deletes gov_balance_sheet in listing", %{conn: conn, gov_balance_sheet: gov_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gov_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gov_balance_sheet-#{gov_balance_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gov_balance_sheet-#{gov_balance_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_gov_balance_sheet]

    test "displays gov_balance_sheet", %{conn: conn, gov_balance_sheet: gov_balance_sheet} do
      {:ok, _show_live, html} = live(conn, Routes.gov_balance_sheet_show_path(conn, :show, gov_balance_sheet))

      assert html =~ "Show Gov balance sheet"
      assert html =~ gov_balance_sheet.monetary_unit
    end

    test "updates gov_balance_sheet within modal", %{conn: conn, gov_balance_sheet: gov_balance_sheet} do
      {:ok, show_live, _html} = live(conn, Routes.gov_balance_sheet_show_path(conn, :show, gov_balance_sheet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gov balance sheet"

      assert_patch(show_live, Routes.gov_balance_sheet_show_path(conn, :edit, gov_balance_sheet))

      assert show_live
             |> form("#gov_balance_sheet-form", gov_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gov_balance_sheet-form", gov_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gov_balance_sheet_show_path(conn, :show, gov_balance_sheet))

      assert html =~ "Gov balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end
  end
end
