defmodule CoreaWeb.GeoLogLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.GeoLogs

  @create_attrs %{latitude: "some latitude"}
  @update_attrs %{latitude: "some updated latitude"}
  @invalid_attrs %{latitude: nil}

  defp fixture(:geo_log) do
    {:ok, geo_log} = GeoLogs.create_geo_log(@create_attrs)
    geo_log
  end

  defp create_geo_log(_) do
    geo_log = fixture(:geo_log)
    %{geo_log: geo_log}
  end

  describe "Index" do
    setup [:create_geo_log]

    test "lists all geo_logs", %{conn: conn, geo_log: geo_log} do
      {:ok, _index_live, html} = live(conn, Routes.geo_log_index_path(conn, :index))

      assert html =~ "Listing Geo logs"
      assert html =~ geo_log.latitude
    end

    test "saves new geo_log", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.geo_log_index_path(conn, :index))

      assert index_live |> element("a", "New Geo log") |> render_click() =~
               "New Geo log"

      assert_patch(index_live, Routes.geo_log_index_path(conn, :new))

      assert index_live
             |> form("#geo_log-form", geo_log: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#geo_log-form", geo_log: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.geo_log_index_path(conn, :index))

      assert html =~ "Geo log created successfully"
      assert html =~ "some latitude"
    end

    test "updates geo_log in listing", %{conn: conn, geo_log: geo_log} do
      {:ok, index_live, _html} = live(conn, Routes.geo_log_index_path(conn, :index))

      assert index_live |> element("#geo_log-#{geo_log.id} a", "Edit") |> render_click() =~
               "Edit Geo log"

      assert_patch(index_live, Routes.geo_log_index_path(conn, :edit, geo_log))

      assert index_live
             |> form("#geo_log-form", geo_log: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#geo_log-form", geo_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.geo_log_index_path(conn, :index))

      assert html =~ "Geo log updated successfully"
      assert html =~ "some updated latitude"
    end

    test "deletes geo_log in listing", %{conn: conn, geo_log: geo_log} do
      {:ok, index_live, _html} = live(conn, Routes.geo_log_index_path(conn, :index))

      assert index_live |> element("#geo_log-#{geo_log.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#geo_log-#{geo_log.id}")
    end
  end

  describe "Show" do
    setup [:create_geo_log]

    test "displays geo_log", %{conn: conn, geo_log: geo_log} do
      {:ok, _show_live, html} = live(conn, Routes.geo_log_show_path(conn, :show, geo_log))

      assert html =~ "Show Geo log"
      assert html =~ geo_log.latitude
    end

    test "updates geo_log within modal", %{conn: conn, geo_log: geo_log} do
      {:ok, show_live, _html} = live(conn, Routes.geo_log_show_path(conn, :show, geo_log))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Geo log"

      assert_patch(show_live, Routes.geo_log_show_path(conn, :edit, geo_log))

      assert show_live
             |> form("#geo_log-form", geo_log: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#geo_log-form", geo_log: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.geo_log_show_path(conn, :show, geo_log))

      assert html =~ "Geo log updated successfully"
      assert html =~ "some updated latitude"
    end
  end
end
