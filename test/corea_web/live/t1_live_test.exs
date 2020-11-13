defmodule CoreaWeb.T1LiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T1s

  @create_attrs %{input_name: "some input_name"}
  @update_attrs %{input_name: "some updated input_name"}
  @invalid_attrs %{input_name: nil}

  defp fixture(:t1) do
    {:ok, t1} = T1s.create_t1(@create_attrs)
    t1
  end

  defp create_t1(_) do
    t1 = fixture(:t1)
    %{t1: t1}
  end

  describe "Index" do
    setup [:create_t1]

    test "lists all t1s", %{conn: conn, t1: t1} do
      {:ok, _index_live, html} = live(conn, Routes.t1_index_path(conn, :index))

      assert html =~ "Listing T1s"
      assert html =~ t1.input_name
    end

    test "saves new t1", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t1_index_path(conn, :index))

      assert index_live |> element("a", "New T1") |> render_click() =~
               "New T1"

      assert_patch(index_live, Routes.t1_index_path(conn, :new))

      assert index_live
             |> form("#t1-form", t1: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t1-form", t1: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_index_path(conn, :index))

      assert html =~ "T1 created successfully"
      assert html =~ "some input_name"
    end

    test "updates t1 in listing", %{conn: conn, t1: t1} do
      {:ok, index_live, _html} = live(conn, Routes.t1_index_path(conn, :index))

      assert index_live |> element("#t1-#{t1.id} a", "Edit") |> render_click() =~
               "Edit T1"

      assert_patch(index_live, Routes.t1_index_path(conn, :edit, t1))

      assert index_live
             |> form("#t1-form", t1: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t1-form", t1: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_index_path(conn, :index))

      assert html =~ "T1 updated successfully"
      assert html =~ "some updated input_name"
    end

    test "deletes t1 in listing", %{conn: conn, t1: t1} do
      {:ok, index_live, _html} = live(conn, Routes.t1_index_path(conn, :index))

      assert index_live |> element("#t1-#{t1.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t1-#{t1.id}")
    end
  end

  describe "Show" do
    setup [:create_t1]

    test "displays t1", %{conn: conn, t1: t1} do
      {:ok, _show_live, html} = live(conn, Routes.t1_show_path(conn, :show, t1))

      assert html =~ "Show T1"
      assert html =~ t1.input_name
    end

    test "updates t1 within modal", %{conn: conn, t1: t1} do
      {:ok, show_live, _html} = live(conn, Routes.t1_show_path(conn, :show, t1))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T1"

      assert_patch(show_live, Routes.t1_show_path(conn, :edit, t1))

      assert show_live
             |> form("#t1-form", t1: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t1-form", t1: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t1_show_path(conn, :show, t1))

      assert html =~ "T1 updated successfully"
      assert html =~ "some updated input_name"
    end
  end
end
