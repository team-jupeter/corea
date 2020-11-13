defmodule CoreaWeb.T4LiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T4s

  @create_attrs %{input_name: "some input_name"}
  @update_attrs %{input_name: "some updated input_name"}
  @invalid_attrs %{input_name: nil}

  defp fixture(:t4) do
    {:ok, t4} = T4s.create_t4(@create_attrs)
    t4
  end

  defp create_t4(_) do
    t4 = fixture(:t4)
    %{t4: t4}
  end

  describe "Index" do
    setup [:create_t4]

    test "lists all t4s", %{conn: conn, t4: t4} do
      {:ok, _index_live, html} = live(conn, Routes.t4_index_path(conn, :index))

      assert html =~ "Listing T4s"
      assert html =~ t4.input_name
    end

    test "saves new t4", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t4_index_path(conn, :index))

      assert index_live |> element("a", "New T4") |> render_click() =~
               "New T4"

      assert_patch(index_live, Routes.t4_index_path(conn, :new))

      assert index_live
             |> form("#t4-form", t4: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t4-form", t4: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_index_path(conn, :index))

      assert html =~ "T4 created successfully"
      assert html =~ "some input_name"
    end

    test "updates t4 in listing", %{conn: conn, t4: t4} do
      {:ok, index_live, _html} = live(conn, Routes.t4_index_path(conn, :index))

      assert index_live |> element("#t4-#{t4.id} a", "Edit") |> render_click() =~
               "Edit T4"

      assert_patch(index_live, Routes.t4_index_path(conn, :edit, t4))

      assert index_live
             |> form("#t4-form", t4: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t4-form", t4: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_index_path(conn, :index))

      assert html =~ "T4 updated successfully"
      assert html =~ "some updated input_name"
    end

    test "deletes t4 in listing", %{conn: conn, t4: t4} do
      {:ok, index_live, _html} = live(conn, Routes.t4_index_path(conn, :index))

      assert index_live |> element("#t4-#{t4.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t4-#{t4.id}")
    end
  end

  describe "Show" do
    setup [:create_t4]

    test "displays t4", %{conn: conn, t4: t4} do
      {:ok, _show_live, html} = live(conn, Routes.t4_show_path(conn, :show, t4))

      assert html =~ "Show T4"
      assert html =~ t4.input_name
    end

    test "updates t4 within modal", %{conn: conn, t4: t4} do
      {:ok, show_live, _html} = live(conn, Routes.t4_show_path(conn, :show, t4))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T4"

      assert_patch(show_live, Routes.t4_show_path(conn, :edit, t4))

      assert show_live
             |> form("#t4-form", t4: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t4-form", t4: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t4_show_path(conn, :show, t4))

      assert html =~ "T4 updated successfully"
      assert html =~ "some updated input_name"
    end
  end
end
