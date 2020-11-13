defmodule CoreaWeb.RealEstateLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.RealEstates

  @create_attrs %{category: "some category"}
  @update_attrs %{category: "some updated category"}
  @invalid_attrs %{category: nil}

  defp fixture(:real_estate) do
    {:ok, real_estate} = RealEstates.create_real_estate(@create_attrs)
    real_estate
  end

  defp create_real_estate(_) do
    real_estate = fixture(:real_estate)
    %{real_estate: real_estate}
  end

  describe "Index" do
    setup [:create_real_estate]

    test "lists all real_estates", %{conn: conn, real_estate: real_estate} do
      {:ok, _index_live, html} = live(conn, Routes.real_estate_index_path(conn, :index))

      assert html =~ "Listing Real estates"
      assert html =~ real_estate.category
    end

    test "saves new real_estate", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.real_estate_index_path(conn, :index))

      assert index_live |> element("a", "New Real estate") |> render_click() =~
               "New Real estate"

      assert_patch(index_live, Routes.real_estate_index_path(conn, :new))

      assert index_live
             |> form("#real_estate-form", real_estate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#real_estate-form", real_estate: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.real_estate_index_path(conn, :index))

      assert html =~ "Real estate created successfully"
      assert html =~ "some category"
    end

    test "updates real_estate in listing", %{conn: conn, real_estate: real_estate} do
      {:ok, index_live, _html} = live(conn, Routes.real_estate_index_path(conn, :index))

      assert index_live |> element("#real_estate-#{real_estate.id} a", "Edit") |> render_click() =~
               "Edit Real estate"

      assert_patch(index_live, Routes.real_estate_index_path(conn, :edit, real_estate))

      assert index_live
             |> form("#real_estate-form", real_estate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#real_estate-form", real_estate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.real_estate_index_path(conn, :index))

      assert html =~ "Real estate updated successfully"
      assert html =~ "some updated category"
    end

    test "deletes real_estate in listing", %{conn: conn, real_estate: real_estate} do
      {:ok, index_live, _html} = live(conn, Routes.real_estate_index_path(conn, :index))

      assert index_live |> element("#real_estate-#{real_estate.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#real_estate-#{real_estate.id}")
    end
  end

  describe "Show" do
    setup [:create_real_estate]

    test "displays real_estate", %{conn: conn, real_estate: real_estate} do
      {:ok, _show_live, html} = live(conn, Routes.real_estate_show_path(conn, :show, real_estate))

      assert html =~ "Show Real estate"
      assert html =~ real_estate.category
    end

    test "updates real_estate within modal", %{conn: conn, real_estate: real_estate} do
      {:ok, show_live, _html} = live(conn, Routes.real_estate_show_path(conn, :show, real_estate))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Real estate"

      assert_patch(show_live, Routes.real_estate_show_path(conn, :edit, real_estate))

      assert show_live
             |> form("#real_estate-form", real_estate: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#real_estate-form", real_estate: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.real_estate_show_path(conn, :show, real_estate))

      assert html =~ "Real estate updated successfully"
      assert html =~ "some updated category"
    end
  end
end
