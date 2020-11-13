defmodule CoreaWeb.T5LiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.T5s

  @create_attrs %{input_name: "some input_name"}
  @update_attrs %{input_name: "some updated input_name"}
  @invalid_attrs %{input_name: nil}

  defp fixture(:t5) do
    {:ok, t5} = T5s.create_t5(@create_attrs)
    t5
  end

  defp create_t5(_) do
    t5 = fixture(:t5)
    %{t5: t5}
  end

  describe "Index" do
    setup [:create_t5]

    test "lists all t5s", %{conn: conn, t5: t5} do
      {:ok, _index_live, html} = live(conn, Routes.t5_index_path(conn, :index))

      assert html =~ "Listing T5s"
      assert html =~ t5.input_name
    end

    test "saves new t5", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.t5_index_path(conn, :index))

      assert index_live |> element("a", "New T5") |> render_click() =~
               "New T5"

      assert_patch(index_live, Routes.t5_index_path(conn, :new))

      assert index_live
             |> form("#t5-form", t5: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t5-form", t5: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t5_index_path(conn, :index))

      assert html =~ "T5 created successfully"
      assert html =~ "some input_name"
    end

    test "updates t5 in listing", %{conn: conn, t5: t5} do
      {:ok, index_live, _html} = live(conn, Routes.t5_index_path(conn, :index))

      assert index_live |> element("#t5-#{t5.id} a", "Edit") |> render_click() =~
               "Edit T5"

      assert_patch(index_live, Routes.t5_index_path(conn, :edit, t5))

      assert index_live
             |> form("#t5-form", t5: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#t5-form", t5: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t5_index_path(conn, :index))

      assert html =~ "T5 updated successfully"
      assert html =~ "some updated input_name"
    end

    test "deletes t5 in listing", %{conn: conn, t5: t5} do
      {:ok, index_live, _html} = live(conn, Routes.t5_index_path(conn, :index))

      assert index_live |> element("#t5-#{t5.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#t5-#{t5.id}")
    end
  end

  describe "Show" do
    setup [:create_t5]

    test "displays t5", %{conn: conn, t5: t5} do
      {:ok, _show_live, html} = live(conn, Routes.t5_show_path(conn, :show, t5))

      assert html =~ "Show T5"
      assert html =~ t5.input_name
    end

    test "updates t5 within modal", %{conn: conn, t5: t5} do
      {:ok, show_live, _html} = live(conn, Routes.t5_show_path(conn, :show, t5))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T5"

      assert_patch(show_live, Routes.t5_show_path(conn, :edit, t5))

      assert show_live
             |> form("#t5-form", t5: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#t5-form", t5: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.t5_show_path(conn, :show, t5))

      assert html =~ "T5 updated successfully"
      assert html =~ "some updated input_name"
    end
  end
end
