defmodule CoreaWeb.OrdinanceLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Ordinances

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp fixture(:ordinance) do
    {:ok, ordinance} = Ordinances.create_ordinance(@create_attrs)
    ordinance
  end

  defp create_ordinance(_) do
    ordinance = fixture(:ordinance)
    %{ordinance: ordinance}
  end

  describe "Index" do
    setup [:create_ordinance]

    test "lists all ordinances", %{conn: conn, ordinance: ordinance} do
      {:ok, _index_live, html} = live(conn, Routes.ordinance_index_path(conn, :index))

      assert html =~ "Listing Ordinances"
      assert html =~ ordinance.title
    end

    test "saves new ordinance", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ordinance_index_path(conn, :index))

      assert index_live |> element("a", "New Ordinance") |> render_click() =~
               "New Ordinance"

      assert_patch(index_live, Routes.ordinance_index_path(conn, :new))

      assert index_live
             |> form("#ordinance-form", ordinance: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ordinance-form", ordinance: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordinance_index_path(conn, :index))

      assert html =~ "Ordinance created successfully"
      assert html =~ "some title"
    end

    test "updates ordinance in listing", %{conn: conn, ordinance: ordinance} do
      {:ok, index_live, _html} = live(conn, Routes.ordinance_index_path(conn, :index))

      assert index_live |> element("#ordinance-#{ordinance.id} a", "Edit") |> render_click() =~
               "Edit Ordinance"

      assert_patch(index_live, Routes.ordinance_index_path(conn, :edit, ordinance))

      assert index_live
             |> form("#ordinance-form", ordinance: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ordinance-form", ordinance: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordinance_index_path(conn, :index))

      assert html =~ "Ordinance updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes ordinance in listing", %{conn: conn, ordinance: ordinance} do
      {:ok, index_live, _html} = live(conn, Routes.ordinance_index_path(conn, :index))

      assert index_live |> element("#ordinance-#{ordinance.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ordinance-#{ordinance.id}")
    end
  end

  describe "Show" do
    setup [:create_ordinance]

    test "displays ordinance", %{conn: conn, ordinance: ordinance} do
      {:ok, _show_live, html} = live(conn, Routes.ordinance_show_path(conn, :show, ordinance))

      assert html =~ "Show Ordinance"
      assert html =~ ordinance.title
    end

    test "updates ordinance within modal", %{conn: conn, ordinance: ordinance} do
      {:ok, show_live, _html} = live(conn, Routes.ordinance_show_path(conn, :show, ordinance))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ordinance"

      assert_patch(show_live, Routes.ordinance_show_path(conn, :edit, ordinance))

      assert show_live
             |> form("#ordinance-form", ordinance: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ordinance-form", ordinance: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ordinance_show_path(conn, :show, ordinance))

      assert html =~ "Ordinance updated successfully"
      assert html =~ "some updated title"
    end
  end
end
