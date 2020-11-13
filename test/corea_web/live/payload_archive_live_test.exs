defmodule CoreaWeb.PayloadArchiveLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.PayloadArchives

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:payload_archive) do
    {:ok, payload_archive} = PayloadArchives.create_payload_archive(@create_attrs)
    payload_archive
  end

  defp create_payload_archive(_) do
    payload_archive = fixture(:payload_archive)
    %{payload_archive: payload_archive}
  end

  describe "Index" do
    setup [:create_payload_archive]

    test "lists all payload_archives", %{conn: conn, payload_archive: payload_archive} do
      {:ok, _index_live, html} = live(conn, Routes.payload_archive_index_path(conn, :index))

      assert html =~ "Listing Payload archives"
      assert html =~ payload_archive.title
    end

    test "saves new payload_archive", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.payload_archive_index_path(conn, :index))

      assert index_live |> element("a", "New Payload archive") |> render_click() =~
               "New Payload archive"

      assert_patch(index_live, Routes.payload_archive_index_path(conn, :new))

      assert index_live
             |> form("#payload_archive-form", payload_archive: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payload_archive-form", payload_archive: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_archive_index_path(conn, :index))

      assert html =~ "Payload archive created successfully"
      assert html =~ "some title"
    end

    test "updates payload_archive in listing", %{conn: conn, payload_archive: payload_archive} do
      {:ok, index_live, _html} = live(conn, Routes.payload_archive_index_path(conn, :index))

      assert index_live |> element("#payload_archive-#{payload_archive.id} a", "Edit") |> render_click() =~
               "Edit Payload archive"

      assert_patch(index_live, Routes.payload_archive_index_path(conn, :edit, payload_archive))

      assert index_live
             |> form("#payload_archive-form", payload_archive: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payload_archive-form", payload_archive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_archive_index_path(conn, :index))

      assert html =~ "Payload archive updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes payload_archive in listing", %{conn: conn, payload_archive: payload_archive} do
      {:ok, index_live, _html} = live(conn, Routes.payload_archive_index_path(conn, :index))

      assert index_live |> element("#payload_archive-#{payload_archive.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payload_archive-#{payload_archive.id}")
    end
  end

  describe "Show" do
    setup [:create_payload_archive]

    test "displays payload_archive", %{conn: conn, payload_archive: payload_archive} do
      {:ok, _show_live, html} = live(conn, Routes.payload_archive_show_path(conn, :show, payload_archive))

      assert html =~ "Show Payload archive"
      assert html =~ payload_archive.title
    end

    test "updates payload_archive within modal", %{conn: conn, payload_archive: payload_archive} do
      {:ok, show_live, _html} = live(conn, Routes.payload_archive_show_path(conn, :show, payload_archive))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payload archive"

      assert_patch(show_live, Routes.payload_archive_show_path(conn, :edit, payload_archive))

      assert show_live
             |> form("#payload_archive-form", payload_archive: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#payload_archive-form", payload_archive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payload_archive_show_path(conn, :show, payload_archive))

      assert html =~ "Payload archive updated successfully"
      assert html =~ "some updated title"
    end
  end
end
