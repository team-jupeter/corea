defmodule CoreaWeb.FinancialReportLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.FinancialReports

  @create_attrs %{entity_name: "some entity_name"}
  @update_attrs %{entity_name: "some updated entity_name"}
  @invalid_attrs %{entity_name: nil}

  defp fixture(:financial_report) do
    {:ok, financial_report} = FinancialReports.create_financial_report(@create_attrs)
    financial_report
  end

  defp create_financial_report(_) do
    financial_report = fixture(:financial_report)
    %{financial_report: financial_report}
  end

  describe "Index" do
    setup [:create_financial_report]

    test "lists all financial_reports", %{conn: conn, financial_report: financial_report} do
      {:ok, _index_live, html} = live(conn, Routes.financial_report_index_path(conn, :index))

      assert html =~ "Listing Financial reports"
      assert html =~ financial_report.entity_name
    end

    test "saves new financial_report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.financial_report_index_path(conn, :index))

      assert index_live |> element("a", "New Financial report") |> render_click() =~
               "New Financial report"

      assert_patch(index_live, Routes.financial_report_index_path(conn, :new))

      assert index_live
             |> form("#financial_report-form", financial_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#financial_report-form", financial_report: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_report_index_path(conn, :index))

      assert html =~ "Financial report created successfully"
      assert html =~ "some entity_name"
    end

    test "updates financial_report in listing", %{conn: conn, financial_report: financial_report} do
      {:ok, index_live, _html} = live(conn, Routes.financial_report_index_path(conn, :index))

      assert index_live |> element("#financial_report-#{financial_report.id} a", "Edit") |> render_click() =~
               "Edit Financial report"

      assert_patch(index_live, Routes.financial_report_index_path(conn, :edit, financial_report))

      assert index_live
             |> form("#financial_report-form", financial_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#financial_report-form", financial_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_report_index_path(conn, :index))

      assert html =~ "Financial report updated successfully"
      assert html =~ "some updated entity_name"
    end

    test "deletes financial_report in listing", %{conn: conn, financial_report: financial_report} do
      {:ok, index_live, _html} = live(conn, Routes.financial_report_index_path(conn, :index))

      assert index_live |> element("#financial_report-#{financial_report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#financial_report-#{financial_report.id}")
    end
  end

  describe "Show" do
    setup [:create_financial_report]

    test "displays financial_report", %{conn: conn, financial_report: financial_report} do
      {:ok, _show_live, html} = live(conn, Routes.financial_report_show_path(conn, :show, financial_report))

      assert html =~ "Show Financial report"
      assert html =~ financial_report.entity_name
    end

    test "updates financial_report within modal", %{conn: conn, financial_report: financial_report} do
      {:ok, show_live, _html} = live(conn, Routes.financial_report_show_path(conn, :show, financial_report))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Financial report"

      assert_patch(show_live, Routes.financial_report_show_path(conn, :edit, financial_report))

      assert show_live
             |> form("#financial_report-form", financial_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#financial_report-form", financial_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.financial_report_show_path(conn, :show, financial_report))

      assert html =~ "Financial report updated successfully"
      assert html =~ "some updated entity_name"
    end
  end
end
