defmodule CoreaWeb.T2LiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T2s

  @create_attrs %{input_name: "some input_name"}
  @update_attrs %{input_name: "some updated input_name"}
  @invalid_attrs %{input_name: nil}

  defp fixture(:t2) do
    {:ok, t2} = T2s.create_t2(@create_attrs)
    t2
  end

  defp create_t2(_) do
    t2 = fixture(:t2)
    %{t2: t2}
  end

  describe "Index" do
    setup [:create_t2]

    test "lists all t2s", %{conn: conn, t2: t2} do
      {:ok, _index_live, html} = live(conn, Routes.t2_index_path(conn, :index))

      assert html =~ "Listing T2s"
      assert html =~ t2.input_name
    end

    test "saves new t2", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t2_index_path(conn, :index))

      assert index_live |> element("a", "New T2") |> render_click() =~
               "New T2"

      assert_patch(index_live, Routes.t2_index_path(conn, :new))

      assert index_live
             |> form("#t2-form", t2: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t2-form", t2: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_index_path(conn, :index))

      assert html =~ "T2 created successfully"
      assert html =~ "some input_name"
    end

    test "updates t2 in listing", %{conn: conn, t2: t2} do
      {:ok, index_live, _html} = live(conn, Routes.t2_index_path(conn, :index))

      assert index_live |> element("#t2-#{t2.id} a", "Edit") |> render_click() =~
               "Edit T2"

      assert_patch(index_live, Routes.t2_index_path(conn, :edit, t2))

      assert index_live
             |> form("#t2-form", t2: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t2-form", t2: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_index_path(conn, :index))

      assert html =~ "T2 updated successfully"
      assert html =~ "some updated input_name"
    end

    test "deletes t2 in listing", %{conn: conn, t2: t2} do
      {:ok, index_live, _html} = live(conn, Routes.t2_index_path(conn, :index))

      assert index_live |> element("#t2-#{t2.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t2-#{t2.id}")
    end
  end

  describe "Show" do
    setup [:create_t2]

    test "displays t2", %{conn: conn, t2: t2} do
      {:ok, _show_live, html} = live(conn, Routes.t2_show_path(conn, :show, t2))

      assert html =~ "Show T2"
      assert html =~ t2.input_name
    end

    test "updates t2 within modal", %{conn: conn, t2: t2} do
      {:ok, show_live, _html} = live(conn, Routes.t2_show_path(conn, :show, t2))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T2"

      assert_patch(show_live, Routes.t2_show_path(conn, :edit, t2))

      assert show_live
             |> form("#t2-form", t2: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t2-form", t2: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t2_show_path(conn, :show, t2))

      assert html =~ "T2 updated successfully"
      assert html =~ "some updated input_name"
    end
  end
end
