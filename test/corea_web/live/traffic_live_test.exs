defmodule CoreaWeb.TrafficLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Traffics

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp fixture(:traffic) do
    {:ok, traffic} = Traffics.create_traffic(@create_attrs)
    traffic
  end

  defp create_traffic(_) do
    traffic = fixture(:traffic)
    %{traffic: traffic}
  end

  describe "Index" do
    setup [:create_traffic]

    test "lists all traffics", %{conn: conn, traffic: traffic} do
      {:ok, _index_live, html} = live(conn, Routes.traffic_index_path(conn, :index))

      assert html =~ "Listing Traffics"
      assert html =~ traffic.type
    end

    test "saves new traffic", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.traffic_index_path(conn, :index))

      assert index_live |> element("a", "New Traffic") |> render_click() =~
               "New Traffic"

      assert_patch(index_live, Routes.traffic_index_path(conn, :new))

      assert index_live
             |> form("#traffic-form", traffic: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#traffic-form", traffic: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.traffic_index_path(conn, :index))

      assert html =~ "Traffic created successfully"
      assert html =~ "some type"
    end

    test "updates traffic in listing", %{conn: conn, traffic: traffic} do
      {:ok, index_live, _html} = live(conn, Routes.traffic_index_path(conn, :index))

      assert index_live |> element("#traffic-#{traffic.id} a", "Edit") |> render_click() =~
               "Edit Traffic"

      assert_patch(index_live, Routes.traffic_index_path(conn, :edit, traffic))

      assert index_live
             |> form("#traffic-form", traffic: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#traffic-form", traffic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.traffic_index_path(conn, :index))

      assert html =~ "Traffic updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes traffic in listing", %{conn: conn, traffic: traffic} do
      {:ok, index_live, _html} = live(conn, Routes.traffic_index_path(conn, :index))

      assert index_live |> element("#traffic-#{traffic.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#traffic-#{traffic.id}")
    end
  end

  describe "Show" do
    setup [:create_traffic]

    test "displays traffic", %{conn: conn, traffic: traffic} do
      {:ok, _show_live, html} = live(conn, Routes.traffic_show_path(conn, :show, traffic))

      assert html =~ "Show Traffic"
      assert html =~ traffic.type
    end

    test "updates traffic within modal", %{conn: conn, traffic: traffic} do
      {:ok, show_live, _html} = live(conn, Routes.traffic_show_path(conn, :show, traffic))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Traffic"

      assert_patch(show_live, Routes.traffic_show_path(conn, :edit, traffic))

      assert show_live
             |> form("#traffic-form", traffic: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#traffic-form", traffic: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.traffic_show_path(conn, :show, traffic))

      assert html =~ "Traffic updated successfully"
      assert html =~ "some updated type"
    end
  end
end
