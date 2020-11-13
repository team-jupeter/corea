defmodule CoreaWeb.OpenhashLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Openhashes

  @create_attrs %{input_email: "some input_email"}
  @update_attrs %{input_email: "some updated input_email"}
  @invalid_attrs %{input_email: nil}

  defp fixture(:openhash) do
    {:ok, openhash} = Openhashes.create_openhash(@create_attrs)
    openhash
  end

  defp create_openhash(_) do
    openhash = fixture(:openhash)
    %{openhash: openhash}
  end

  describe "Index" do
    setup [:create_openhash]

    test "lists all openhashes", %{conn: conn, openhash: openhash} do
      {:ok, _index_live, html} = live(conn, Routes.openhash_index_path(conn, :index))

      assert html =~ "Listing Openhashes"
      assert html =~ openhash.input_email
    end

    test "saves new openhash", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.openhash_index_path(conn, :index))

      assert index_live |> element("a", "New Openhash") |> render_click() =~
               "New Openhash"

      assert_patch(index_live, Routes.openhash_index_path(conn, :new))

      assert index_live
             |> form("#openhash-form", openhash: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#openhash-form", openhash: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.openhash_index_path(conn, :index))

      assert html =~ "Openhash created successfully"
      assert html =~ "some input_email"
    end

    test "updates openhash in listing", %{conn: conn, openhash: openhash} do
      {:ok, index_live, _html} = live(conn, Routes.openhash_index_path(conn, :index))

      assert index_live |> element("#openhash-#{openhash.id} a", "Edit") |> render_click() =~
               "Edit Openhash"

      assert_patch(index_live, Routes.openhash_index_path(conn, :edit, openhash))

      assert index_live
             |> form("#openhash-form", openhash: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#openhash-form", openhash: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.openhash_index_path(conn, :index))

      assert html =~ "Openhash updated successfully"
      assert html =~ "some updated input_email"
    end

    test "deletes openhash in listing", %{conn: conn, openhash: openhash} do
      {:ok, index_live, _html} = live(conn, Routes.openhash_index_path(conn, :index))

      assert index_live |> element("#openhash-#{openhash.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#openhash-#{openhash.id}")
    end
  end

  describe "Show" do
    setup [:create_openhash]

    test "displays openhash", %{conn: conn, openhash: openhash} do
      {:ok, _show_live, html} = live(conn, Routes.openhash_show_path(conn, :show, openhash))

      assert html =~ "Show Openhash"
      assert html =~ openhash.input_email
    end

    test "updates openhash within modal", %{conn: conn, openhash: openhash} do
      {:ok, show_live, _html} = live(conn, Routes.openhash_show_path(conn, :show, openhash))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Openhash"

      assert_patch(show_live, Routes.openhash_show_path(conn, :edit, openhash))

      assert show_live
             |> form("#openhash-form", openhash: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#openhash-form", openhash: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.openhash_show_path(conn, :show, openhash))

      assert html =~ "Openhash updated successfully"
      assert html =~ "some updated input_email"
    end
  end
end
