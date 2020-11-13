defmodule CoreaWeb.ProductAnnotationLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.ProductAnnotations

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  defp fixture(:product_annotation) do
    {:ok, product_annotation} = ProductAnnotations.create_product_annotation(@create_attrs)
    product_annotation
  end

  defp create_product_annotation(_) do
    product_annotation = fixture(:product_annotation)
    %{product_annotation: product_annotation}
  end

  describe "Index" do
    setup [:create_product_annotation]

    test "lists all product_annotations", %{conn: conn, product_annotation: product_annotation} do
      {:ok, _index_live, html} = live(conn, Routes.product_annotation_index_path(conn, :index))

      assert html =~ "Listing Product annotations"
      assert html =~ product_annotation.body
    end

    test "saves new product_annotation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.product_annotation_index_path(conn, :index))

      assert index_live |> element("a", "New Product annotation") |> render_click() =~
               "New Product annotation"

      assert_patch(index_live, Routes.product_annotation_index_path(conn, :new))

      assert index_live
             |> form("#product_annotation-form", product_annotation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_annotation-form", product_annotation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_annotation_index_path(conn, :index))

      assert html =~ "Product annotation created successfully"
      assert html =~ "some body"
    end

    test "updates product_annotation in listing", %{conn: conn, product_annotation: product_annotation} do
      {:ok, index_live, _html} = live(conn, Routes.product_annotation_index_path(conn, :index))

      assert index_live |> element("#product_annotation-#{product_annotation.id} a", "Edit") |> render_click() =~
               "Edit Product annotation"

      assert_patch(index_live, Routes.product_annotation_index_path(conn, :edit, product_annotation))

      assert index_live
             |> form("#product_annotation-form", product_annotation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#product_annotation-form", product_annotation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_annotation_index_path(conn, :index))

      assert html =~ "Product annotation updated successfully"
      assert html =~ "some updated body"
    end

    test "deletes product_annotation in listing", %{conn: conn, product_annotation: product_annotation} do
      {:ok, index_live, _html} = live(conn, Routes.product_annotation_index_path(conn, :index))

      assert index_live |> element("#product_annotation-#{product_annotation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#product_annotation-#{product_annotation.id}")
    end
  end

  describe "Show" do
    setup [:create_product_annotation]

    test "displays product_annotation", %{conn: conn, product_annotation: product_annotation} do
      {:ok, _show_live, html} = live(conn, Routes.product_annotation_show_path(conn, :show, product_annotation))

      assert html =~ "Show Product annotation"
      assert html =~ product_annotation.body
    end

    test "updates product_annotation within modal", %{conn: conn, product_annotation: product_annotation} do
      {:ok, show_live, _html} = live(conn, Routes.product_annotation_show_path(conn, :show, product_annotation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Product annotation"

      assert_patch(show_live, Routes.product_annotation_show_path(conn, :edit, product_annotation))

      assert show_live
             |> form("#product_annotation-form", product_annotation: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#product_annotation-form", product_annotation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.product_annotation_show_path(conn, :show, product_annotation))

      assert html =~ "Product annotation updated successfully"
      assert html =~ "some updated body"
    end
  end
end
