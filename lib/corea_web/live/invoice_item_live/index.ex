defmodule CoreaWeb.InvoiceItemLive.Index do
  use CoreaWeb, :live_view

  alias Corea.InvoiceItems
  alias Corea.InvoiceItems.InvoiceItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :invoice_items, list_invoice_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Invoice item")
    |> assign(:invoice_item, InvoiceItems.get_invoice_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Invoice item")
    |> assign(:invoice_item, %InvoiceItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Invoice items")
    |> assign(:invoice_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    {:ok, _} = InvoiceItems.delete_invoice_item(invoice_item)

    {:noreply, assign(socket, :invoice_items, list_invoice_items())}
  end

  defp list_invoice_items do
    InvoiceItems.list_invoice_items()
  end
end
