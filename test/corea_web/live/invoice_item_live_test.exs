defmodule CoreaWeb.InvoiceItemLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.InvoiceItems

  @create_attrs %{item_name: "some item_name"}
  @update_attrs %{item_name: "some updated item_name"}
  @invalid_attrs %{item_name: nil}

  defp fixture(:invoice_item) do
    {:ok, invoice_item} = InvoiceItems.create_invoice_item(@create_attrs)
    invoice_item
  end

  defp create_invoice_item(_) do
    invoice_item = fixture(:invoice_item)
    %{invoice_item: invoice_item}
  end

  describe "Index" do
    setup [:create_invoice_item]

    test "lists all invoice_items", %{conn: conn, invoice_item: invoice_item} do
      {:ok, _index_live, html} = live(conn, Routes.invoice_item_index_path(conn, :index))

      assert html =~ "Listing Invoice items"
      assert html =~ invoice_item.item_name
    end

    test "saves new invoice_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_item_index_path(conn, :index))

      assert index_live |> element("a", "New Invoice item") |> render_click() =~
               "New Invoice item"

      assert_patch(index_live, Routes.invoice_item_index_path(conn, :new))

      assert index_live
             |> form("#invoice_item-form", invoice_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#invoice_item-form", invoice_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_item_index_path(conn, :index))

      assert html =~ "Invoice item created successfully"
      assert html =~ "some item_name"
    end

    test "updates invoice_item in listing", %{conn: conn, invoice_item: invoice_item} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_item_index_path(conn, :index))

      assert index_live |> element("#invoice_item-#{invoice_item.id} a", "Edit") |> render_click() =~
               "Edit Invoice item"

      assert_patch(index_live, Routes.invoice_item_index_path(conn, :edit, invoice_item))

      assert index_live
             |> form("#invoice_item-form", invoice_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#invoice_item-form", invoice_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_item_index_path(conn, :index))

      assert html =~ "Invoice item updated successfully"
      assert html =~ "some updated item_name"
    end

    test "deletes invoice_item in listing", %{conn: conn, invoice_item: invoice_item} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_item_index_path(conn, :index))

      assert index_live |> element("#invoice_item-#{invoice_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#invoice_item-#{invoice_item.id}")
    end
  end

  describe "Show" do
    setup [:create_invoice_item]

    test "displays invoice_item", %{conn: conn, invoice_item: invoice_item} do
      {:ok, _show_live, html} = live(conn, Routes.invoice_item_show_path(conn, :show, invoice_item))

      assert html =~ "Show Invoice item"
      assert html =~ invoice_item.item_name
    end

    test "updates invoice_item within modal", %{conn: conn, invoice_item: invoice_item} do
      {:ok, show_live, _html} = live(conn, Routes.invoice_item_show_path(conn, :show, invoice_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Invoice item"

      assert_patch(show_live, Routes.invoice_item_show_path(conn, :edit, invoice_item))

      assert show_live
             |> form("#invoice_item-form", invoice_item: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#invoice_item-form", invoice_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_item_show_path(conn, :show, invoice_item))

      assert html =~ "Invoice item updated successfully"
      assert html =~ "some updated item_name"
    end
  end
end
