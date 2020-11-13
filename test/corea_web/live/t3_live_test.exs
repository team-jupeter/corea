defmodule CoreaWeb.T3LiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T3s

  @create_attrs %{input_name: "some input_name"}
  @update_attrs %{input_name: "some updated input_name"}
  @invalid_attrs %{input_name: nil}

  defp fixture(:t3) do
    {:ok, t3} = T3s.create_t3(@create_attrs)
    t3
  end

  defp create_t3(_) do
    t3 = fixture(:t3)
    %{t3: t3}
  end

  describe "Index" do
    setup [:create_t3]

    test "lists all t3s", %{conn: conn, t3: t3} do
      {:ok, _index_live, html} = live(conn, Routes.t3_index_path(conn, :index))

      assert html =~ "Listing T3s"
      assert html =~ t3.input_name
    end

    test "saves new t3", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t3_index_path(conn, :index))

      assert index_live |> element("a", "New T3") |> render_click() =~
               "New T3"

      assert_patch(index_live, Routes.t3_index_path(conn, :new))

      assert index_live
             |> form("#t3-form", t3: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t3-form", t3: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_index_path(conn, :index))

      assert html =~ "T3 created successfully"
      assert html =~ "some input_name"
    end

    test "updates t3 in listing", %{conn: conn, t3: t3} do
      {:ok, index_live, _html} = live(conn, Routes.t3_index_path(conn, :index))

      assert index_live |> element("#t3-#{t3.id} a", "Edit") |> render_click() =~
               "Edit T3"

      assert_patch(index_live, Routes.t3_index_path(conn, :edit, t3))

      assert index_live
             |> form("#t3-form", t3: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t3-form", t3: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_index_path(conn, :index))

      assert html =~ "T3 updated successfully"
      assert html =~ "some updated input_name"
    end

    test "deletes t3 in listing", %{conn: conn, t3: t3} do
      {:ok, index_live, _html} = live(conn, Routes.t3_index_path(conn, :index))

      assert index_live |> element("#t3-#{t3.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t3-#{t3.id}")
    end
  end

  describe "Show" do
    setup [:create_t3]

    test "displays t3", %{conn: conn, t3: t3} do
      {:ok, _show_live, html} = live(conn, Routes.t3_show_path(conn, :show, t3))

      assert html =~ "Show T3"
      assert html =~ t3.input_name
    end

    test "updates t3 within modal", %{conn: conn, t3: t3} do
      {:ok, show_live, _html} = live(conn, Routes.t3_show_path(conn, :show, t3))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T3"

      assert_patch(show_live, Routes.t3_show_path(conn, :edit, t3))

      assert show_live
             |> form("#t3-form", t3: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t3-form", t3: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t3_show_path(conn, :show, t3))

      assert html =~ "T3 updated successfully"
      assert html =~ "some updated input_name"
    end
  end
end
