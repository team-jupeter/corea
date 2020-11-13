defmodule CoreaWeb.InvoiceLiveTest do
  use CoreaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Corea.Invoices

  @create_attrs %{openhash: "some openhash"}
  @update_attrs %{openhash: "some updated openhash"}
  @invalid_attrs %{openhash: nil}

  defp fixture(:invoice) do
    {:ok, invoice} = Invoices.create_invoice(@create_attrs)
    invoice
  end

  defp create_invoice(_) do
    invoice = fixture(:invoice)
    %{invoice: invoice}
  end

  describe "Index" do
    setup [:create_invoice]

    test "lists all invoices", %{conn: conn, invoice: invoice} do
      {:ok, _index_live, html} = live(conn, Routes.invoice_index_path(conn, :index))

      assert html =~ "Listing Invoices"
      assert html =~ invoice.openhash
    end

    test "saves new invoice", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_index_path(conn, :index))

      assert index_live |> element("a", "New Invoice") |> render_click() =~
               "New Invoice"

      assert_patch(index_live, Routes.invoice_index_path(conn, :new))

      assert index_live
             |> form("#invoice-form", invoice: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#invoice-form", invoice: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_index_path(conn, :index))

      assert html =~ "Invoice created successfully"
      assert html =~ "some openhash"
    end

    test "updates invoice in listing", %{conn: conn, invoice: invoice} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_index_path(conn, :index))

      assert index_live |> element("#invoice-#{invoice.id} a", "Edit") |> render_click() =~
               "Edit Invoice"

      assert_patch(index_live, Routes.invoice_index_path(conn, :edit, invoice))

      assert index_live
             |> form("#invoice-form", invoice: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#invoice-form", invoice: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_index_path(conn, :index))

      assert html =~ "Invoice updated successfully"
      assert html =~ "some updated openhash"
    end

    test "deletes invoice in listing", %{conn: conn, invoice: invoice} do
      {:ok, index_live, _html} = live(conn, Routes.invoice_index_path(conn, :index))

      assert index_live |> element("#invoice-#{invoice.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#invoice-#{invoice.id}")
    end
  end

  describe "Show" do
    setup [:create_invoice]

    test "displays invoice", %{conn: conn, invoice: invoice} do
      {:ok, _show_live, html} = live(conn, Routes.invoice_show_path(conn, :show, invoice))

      assert html =~ "Show Invoice"
      assert html =~ invoice.openhash
    end

    test "updates invoice within modal", %{conn: conn, invoice: invoice} do
      {:ok, show_live, _html} = live(conn, Routes.invoice_show_path(conn, :show, invoice))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Invoice"

      assert_patch(show_live, Routes.invoice_show_path(conn, :edit, invoice))

      assert show_live
             |> form("#invoice-form", invoice: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#invoice-form", invoice: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.invoice_show_path(conn, :show, invoice))

      assert html =~ "Invoice updated successfully"
      assert html =~ "some updated openhash"
    end
  end
end
