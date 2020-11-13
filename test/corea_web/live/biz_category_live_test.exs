defmodule CoreaWeb.BizCategoryLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.BizCategories

  @create_attrs %{code: "some code", name: "some name", standard: "some standard"}
  @update_attrs %{code: "some updated code", name: "some updated name", standard: "some updated standard"}
  @invalid_attrs %{code: nil, name: nil, standard: nil}

  defp fixture(:biz_category) do
    {:ok, biz_category} = BizCategories.create_biz_category(@create_attrs)
    biz_category
  end

  defp create_biz_category(_) do
    biz_category = fixture(:biz_category)
    %{biz_category: biz_category}
  end

  describe "Index" do
    setup [:create_biz_category]

    test "lists all biz_categories", %{conn: conn, biz_category: biz_category} do
      {:ok, _index_live, html} = live(conn, Routes.biz_category_index_path(conn, :index))

      assert html =~ "Listing Biz categories"
      assert html =~ biz_category.code
    end

    test "saves new biz_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.biz_category_index_path(conn, :index))

      assert index_live |> element("a", "New Biz category") |> render_click() =~
               "New Biz category"

      assert_patch(index_live, Routes.biz_category_index_path(conn, :new))

      assert index_live
             |> form("#biz_category-form", biz_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#biz_category-form", biz_category: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.biz_category_index_path(conn, :index))

      assert html =~ "Biz category created successfully"
      assert html =~ "some code"
    end

    test "updates biz_category in listing", %{conn: conn, biz_category: biz_category} do
      {:ok, index_live, _html} = live(conn, Routes.biz_category_index_path(conn, :index))

      assert index_live |> element("#biz_category-#{biz_category.id} a", "Edit") |> render_click() =~
               "Edit Biz category"

      assert_patch(index_live, Routes.biz_category_index_path(conn, :edit, biz_category))

      assert index_live
             |> form("#biz_category-form", biz_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#biz_category-form", biz_category: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.biz_category_index_path(conn, :index))

      assert html =~ "Biz category updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes biz_category in listing", %{conn: conn, biz_category: biz_category} do
      {:ok, index_live, _html} = live(conn, Routes.biz_category_index_path(conn, :index))

      assert index_live |> element("#biz_category-#{biz_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#biz_category-#{biz_category.id}")
    end
  end

  describe "Show" do
    setup [:create_biz_category]

    test "displays biz_category", %{conn: conn, biz_category: biz_category} do
      {:ok, _show_live, html} = live(conn, Routes.biz_category_show_path(conn, :show, biz_category))

      assert html =~ "Show Biz category"
      assert html =~ biz_category.code
    end

    test "updates biz_category within modal", %{conn: conn, biz_category: biz_category} do
      {:ok, show_live, _html} = live(conn, Routes.biz_category_show_path(conn, :show, biz_category))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Biz category"

      assert_patch(show_live, Routes.biz_category_show_path(conn, :edit, biz_category))

      assert show_live
             |> form("#biz_category-form", biz_category: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#biz_category-form", biz_category: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.biz_category_show_path(conn, :show, biz_category))

      assert html =~ "Biz category updated successfully"
      assert html =~ "some updated code"
    end
  end
end
