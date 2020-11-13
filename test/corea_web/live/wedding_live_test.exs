defmodule CoreaWeb.WeddingLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Weddings

  @create_attrs %{bride: "some bride"}
  @update_attrs %{bride: "some updated bride"}
  @invalid_attrs %{bride: nil}

  defp fixture(:wedding) do
    {:ok, wedding} = Weddings.create_wedding(@create_attrs)
    wedding
  end

  defp create_wedding(_) do
    wedding = fixture(:wedding)
    %{wedding: wedding}
  end

  describe "Index" do
    setup [:create_wedding]

    test "lists all weddings", %{conn: conn, wedding: wedding} do
      {:ok, _index_live, html} = live(conn, Routes.wedding_index_path(conn, :index))

      assert html =~ "Listing Weddings"
      assert html =~ wedding.bride
    end

    test "saves new wedding", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.wedding_index_path(conn, :index))

      assert index_live |> element("a", "New Wedding") |> render_click() =~
               "New Wedding"

      assert_patch(index_live, Routes.wedding_index_path(conn, :new))

      assert index_live
             |> form("#wedding-form", wedding: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#wedding-form", wedding: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.wedding_index_path(conn, :index))

      assert html =~ "Wedding created successfully"
      assert html =~ "some bride"
    end

    test "updates wedding in listing", %{conn: conn, wedding: wedding} do
      {:ok, index_live, _html} = live(conn, Routes.wedding_index_path(conn, :index))

      assert index_live |> element("#wedding-#{wedding.id} a", "Edit") |> render_click() =~
               "Edit Wedding"

      assert_patch(index_live, Routes.wedding_index_path(conn, :edit, wedding))

      assert index_live
             |> form("#wedding-form", wedding: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#wedding-form", wedding: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.wedding_index_path(conn, :index))

      assert html =~ "Wedding updated successfully"
      assert html =~ "some updated bride"
    end

    test "deletes wedding in listing", %{conn: conn, wedding: wedding} do
      {:ok, index_live, _html} = live(conn, Routes.wedding_index_path(conn, :index))

      assert index_live |> element("#wedding-#{wedding.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#wedding-#{wedding.id}")
    end
  end

  describe "Show" do
    setup [:create_wedding]

    test "displays wedding", %{conn: conn, wedding: wedding} do
      {:ok, _show_live, html} = live(conn, Routes.wedding_show_path(conn, :show, wedding))

      assert html =~ "Show Wedding"
      assert html =~ wedding.bride
    end

    test "updates wedding within modal", %{conn: conn, wedding: wedding} do
      {:ok, show_live, _html} = live(conn, Routes.wedding_show_path(conn, :show, wedding))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Wedding"

      assert_patch(show_live, Routes.wedding_show_path(conn, :edit, wedding))

      assert show_live
             |> form("#wedding-form", wedding: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#wedding-form", wedding: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.wedding_show_path(conn, :show, wedding))

      assert html =~ "Wedding updated successfully"
      assert html =~ "some updated bride"
    end
  end
end
