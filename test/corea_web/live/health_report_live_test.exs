defmodule CoreaWeb.HealthReportLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.HealthReports

  @create_attrs %{dna: "120.5"}
  @update_attrs %{dna: "456.7"}
  @invalid_attrs %{dna: nil}

  defp fixture(:health_report) do
    {:ok, health_report} = HealthReports.create_health_report(@create_attrs)
    health_report
  end

  defp create_health_report(_) do
    health_report = fixture(:health_report)
    %{health_report: health_report}
  end

  describe "Index" do
    setup [:create_health_report]

    test "lists all health_reports", %{conn: conn, health_report: health_report} do
      {:ok, _index_live, html} = live(conn, Routes.health_report_index_path(conn, :index))

      assert html =~ "Listing Health reports"
    end

    test "saves new health_report", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.health_report_index_path(conn, :index))

      assert index_live |> element("a", "New Health report") |> render_click() =~
               "New Health report"

      assert_patch(index_live, Routes.health_report_index_path(conn, :new))

      assert index_live
             |> form("#health_report-form", health_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#health_report-form", health_report: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.health_report_index_path(conn, :index))

      assert html =~ "Health report created successfully"
    end

    test "updates health_report in listing", %{conn: conn, health_report: health_report} do
      {:ok, index_live, _html} = live(conn, Routes.health_report_index_path(conn, :index))

      assert index_live |> element("#health_report-#{health_report.id} a", "Edit") |> render_click() =~
               "Edit Health report"

      assert_patch(index_live, Routes.health_report_index_path(conn, :edit, health_report))

      assert index_live
             |> form("#health_report-form", health_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#health_report-form", health_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.health_report_index_path(conn, :index))

      assert html =~ "Health report updated successfully"
    end

    test "deletes health_report in listing", %{conn: conn, health_report: health_report} do
      {:ok, index_live, _html} = live(conn, Routes.health_report_index_path(conn, :index))

      assert index_live |> element("#health_report-#{health_report.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#health_report-#{health_report.id}")
    end
  end

  describe "Show" do
    setup [:create_health_report]

    test "displays health_report", %{conn: conn, health_report: health_report} do
      {:ok, _show_live, html} = live(conn, Routes.health_report_show_path(conn, :show, health_report))

      assert html =~ "Show Health report"
    end

    test "updates health_report within modal", %{conn: conn, health_report: health_report} do
      {:ok, show_live, _html} = live(conn, Routes.health_report_show_path(conn, :show, health_report))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Health report"

      assert_patch(show_live, Routes.health_report_show_path(conn, :edit, health_report))

      assert show_live
             |> form("#health_report-form", health_report: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#health_report-form", health_report: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.health_report_show_path(conn, :show, health_report))

      assert html =~ "Health report updated successfully"
    end
  end
end
