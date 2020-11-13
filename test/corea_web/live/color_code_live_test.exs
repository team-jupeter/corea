defmodule CoreaWeb.ColorCodeLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.ColorCodes

  @create_attrs %{char_1: 42}
  @update_attrs %{char_1: 43}
  @invalid_attrs %{char_1: nil}

  defp fixture(:color_code) do
    {:ok, color_code} = ColorCodes.create_color_code(@create_attrs)
    color_code
  end

  defp create_color_code(_) do
    color_code = fixture(:color_code)
    %{color_code: color_code}
  end

  describe "Index" do
    setup [:create_color_code]

    test "lists all color_codes", %{conn: conn, color_code: color_code} do
      {:ok, _index_live, html} = live(conn, Routes.color_code_index_path(conn, :index))

      assert html =~ "Listing Color codes"
    end

    test "saves new color_code", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.color_code_index_path(conn, :index))

      assert index_live |> element("a", "New Color code") |> render_click() =~
               "New Color code"

      assert_patch(index_live, Routes.color_code_index_path(conn, :new))

      assert index_live
             |> form("#color_code-form", color_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#color_code-form", color_code: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.color_code_index_path(conn, :index))

      assert html =~ "Color code created successfully"
    end

    test "updates color_code in listing", %{conn: conn, color_code: color_code} do
      {:ok, index_live, _html} = live(conn, Routes.color_code_index_path(conn, :index))

      assert index_live |> element("#color_code-#{color_code.id} a", "Edit") |> render_click() =~
               "Edit Color code"

      assert_patch(index_live, Routes.color_code_index_path(conn, :edit, color_code))

      assert index_live
             |> form("#color_code-form", color_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#color_code-form", color_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.color_code_index_path(conn, :index))

      assert html =~ "Color code updated successfully"
    end

    test "deletes color_code in listing", %{conn: conn, color_code: color_code} do
      {:ok, index_live, _html} = live(conn, Routes.color_code_index_path(conn, :index))

      assert index_live |> element("#color_code-#{color_code.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#color_code-#{color_code.id}")
    end
  end

  describe "Show" do
    setup [:create_color_code]

    test "displays color_code", %{conn: conn, color_code: color_code} do
      {:ok, _show_live, html} = live(conn, Routes.color_code_show_path(conn, :show, color_code))

      assert html =~ "Show Color code"
    end

    test "updates color_code within modal", %{conn: conn, color_code: color_code} do
      {:ok, show_live, _html} = live(conn, Routes.color_code_show_path(conn, :show, color_code))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Color code"

      assert_patch(show_live, Routes.color_code_show_path(conn, :edit, color_code))

      assert show_live
             |> form("#color_code-form", color_code: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#color_code-form", color_code: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.color_code_show_path(conn, :show, color_code))

      assert html =~ "Color code updated successfully"
    end
  end
end
