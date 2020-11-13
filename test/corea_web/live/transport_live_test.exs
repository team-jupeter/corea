defmodule CoreaWeb.TransportLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Transports

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  defp fixture(:transport) do
    {:ok, transport} = Transports.create_transport(@create_attrs)
    transport
  end

  defp create_transport(_) do
    transport = fixture(:transport)
    %{transport: transport}
  end

  describe "Index" do
    setup [:create_transport]

    test "lists all transports", %{conn: conn, transport: transport} do
      {:ok, _index_live, html} = live(conn, Routes.transport_index_path(conn, :index))

      assert html =~ "Listing Transports"
      assert html =~ transport.type
    end

    test "saves new transport", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.transport_index_path(conn, :index))

      assert index_live |> element("a", "New Transport") |> render_click() =~
               "New Transport"

      assert_patch(index_live, Routes.transport_index_path(conn, :new))

      assert index_live
             |> form("#transport-form", transport: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transport-form", transport: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transport_index_path(conn, :index))

      assert html =~ "Transport created successfully"
      assert html =~ "some type"
    end

    test "updates transport in listing", %{conn: conn, transport: transport} do
      {:ok, index_live, _html} = live(conn, Routes.transport_index_path(conn, :index))

      assert index_live |> element("#transport-#{transport.id} a", "Edit") |> render_click() =~
               "Edit Transport"

      assert_patch(index_live, Routes.transport_index_path(conn, :edit, transport))

      assert index_live
             |> form("#transport-form", transport: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transport-form", transport: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transport_index_path(conn, :index))

      assert html =~ "Transport updated successfully"
      assert html =~ "some updated type"
    end

    test "deletes transport in listing", %{conn: conn, transport: transport} do
      {:ok, index_live, _html} = live(conn, Routes.transport_index_path(conn, :index))

      assert index_live |> element("#transport-#{transport.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#transport-#{transport.id}")
    end
  end

  describe "Show" do
    setup [:create_transport]

    test "displays transport", %{conn: conn, transport: transport} do
      {:ok, _show_live, html} = live(conn, Routes.transport_show_path(conn, :show, transport))

      assert html =~ "Show Transport"
      assert html =~ transport.type
    end

    test "updates transport within modal", %{conn: conn, transport: transport} do
      {:ok, show_live, _html} = live(conn, Routes.transport_show_path(conn, :show, transport))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Transport"

      assert_patch(show_live, Routes.transport_show_path(conn, :edit, transport))

      assert show_live
             |> form("#transport-form", transport: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#transport-form", transport: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transport_show_path(conn, :show, transport))

      assert html =~ "Transport updated successfully"
      assert html =~ "some updated type"
    end
  end
end
