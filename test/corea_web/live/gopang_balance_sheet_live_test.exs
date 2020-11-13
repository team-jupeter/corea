defmodule CoreaWeb.GopangBalanceSheetLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GopangBalanceSheets

  @create_attrs %{monetary_unit: "some monetary_unit"}
  @update_attrs %{monetary_unit: "some updated monetary_unit"}
  @invalid_attrs %{monetary_unit: nil}

  defp fixture(:gopang_balance_sheet) do
    {:ok, gopang_balance_sheet} = GopangBalanceSheets.create_gopang_balance_sheet(@create_attrs)
    gopang_balance_sheet
  end

  defp create_gopang_balance_sheet(_) do
    gopang_balance_sheet = fixture(:gopang_balance_sheet)
    %{gopang_balance_sheet: gopang_balance_sheet}
  end

  describe "Index" do
    setup [:create_gopang_balance_sheet]

    test "lists all gopang_balance_sheets", %{conn: conn, gopang_balance_sheet: gopang_balance_sheet} do
      {:ok, _index_live, html} = live(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert html =~ "Listing Gopang balance sheets"
      assert html =~ gopang_balance_sheet.monetary_unit
    end

    test "saves new gopang_balance_sheet", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert index_live |> element("a", "New Gopang balance sheet") |> render_click() =~
               "New Gopang balance sheet"

      assert_patch(index_live, Routes.gopang_balance_sheet_index_path(conn, :new))

      assert index_live
             |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert html =~ "Gopang balance sheet created successfully"
      assert html =~ "some monetary_unit"
    end

    test "updates gopang_balance_sheet in listing", %{conn: conn, gopang_balance_sheet: gopang_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gopang_balance_sheet-#{gopang_balance_sheet.id} a", "Edit") |> render_click() =~
               "Edit Gopang balance sheet"

      assert_patch(index_live, Routes.gopang_balance_sheet_index_path(conn, :edit, gopang_balance_sheet))

      assert index_live
             |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert html =~ "Gopang balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end

    test "deletes gopang_balance_sheet in listing", %{conn: conn, gopang_balance_sheet: gopang_balance_sheet} do
      {:ok, index_live, _html} = live(conn, Routes.gopang_balance_sheet_index_path(conn, :index))

      assert index_live |> element("#gopang_balance_sheet-#{gopang_balance_sheet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gopang_balance_sheet-#{gopang_balance_sheet.id}")
    end
  end

  describe "Show" do
    setup [:create_gopang_balance_sheet]

    test "displays gopang_balance_sheet", %{conn: conn, gopang_balance_sheet: gopang_balance_sheet} do
      {:ok, _show_live, html} = live(conn, Routes.gopang_balance_sheet_show_path(conn, :show, gopang_balance_sheet))

      assert html =~ "Show Gopang balance sheet"
      assert html =~ gopang_balance_sheet.monetary_unit
    end

    test "updates gopang_balance_sheet within modal", %{conn: conn, gopang_balance_sheet: gopang_balance_sheet} do
      {:ok, show_live, _html} = live(conn, Routes.gopang_balance_sheet_show_path(conn, :show, gopang_balance_sheet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gopang balance sheet"

      assert_patch(show_live, Routes.gopang_balance_sheet_show_path(conn, :edit, gopang_balance_sheet))

      assert show_live
             |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#gopang_balance_sheet-form", gopang_balance_sheet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.gopang_balance_sheet_show_path(conn, :show, gopang_balance_sheet))

      assert html =~ "Gopang balance sheet updated successfully"
      assert html =~ "some updated monetary_unit"
    end
  end
end
