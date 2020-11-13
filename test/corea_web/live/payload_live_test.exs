defmodule CoreaWeb.PayloadLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Payloads

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:payload) do
    {:ok, payload} = Payloads.create_payload(@create_attrs)
    payload
  end

  defp create_payload(_) do
    payload = fixture(:payload)
    %{payload: payload}
  end

  describe "Index" do
    setup [:create_payload]

    test "lists all payloads", %{conn: conn, payload: payload} do
      {:ok, _index_live, html} = live(conn, Routes.payload_index_path(conn, :index))

      assert html =~ "Listing Payloads"
      assert html =~ payload.title
    end

    test "saves new payload", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.payload_index_path(conn, :index))

      assert index_live |> element("a", "New Payload") |> render_click() =~
               "New Payload"

      assert_patch(index_live, Routes.payload_index_path(conn, :new))

      assert index_live
             |> form("#payload-form", payload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payload-form", payload: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_index_path(conn, :index))

      assert html =~ "Payload created successfully"
      assert html =~ "some title"
    end

    test "updates payload in listing", %{conn: conn, payload: payload} do
      {:ok, index_live, _html} = live(conn, Routes.payload_index_path(conn, :index))

      assert index_live |> element("#payload-#{payload.id} a", "Edit") |> render_click() =~
               "Edit Payload"

      assert_patch(index_live, Routes.payload_index_path(conn, :edit, payload))

      assert index_live
             |> form("#payload-form", payload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payload-form", payload: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_index_path(conn, :index))

      assert html =~ "Payload updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes payload in listing", %{conn: conn, payload: payload} do
      {:ok, index_live, _html} = live(conn, Routes.payload_index_path(conn, :index))

      assert index_live |> element("#payload-#{payload.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payload-#{payload.id}")
    end
  end

  describe "Show" do
    setup [:create_payload]

    test "displays payload", %{conn: conn, payload: payload} do
      {:ok, _show_live, html} = live(conn, Routes.payload_show_path(conn, :show, payload))

      assert html =~ "Show Payload"
      assert html =~ payload.title
    end

    test "updates payload within modal", %{conn: conn, payload: payload} do
      {:ok, show_live, _html} = live(conn, Routes.payload_show_path(conn, :show, payload))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payload"

      assert_patch(show_live, Routes.payload_show_path(conn, :edit, payload))

      assert show_live
             |> form("#payload-form", payload: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#payload-form", payload: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_show_path(conn, :show, payload))

      assert html =~ "Payload updated successfully"
      assert html =~ "some updated title"
    end
  end
end
