defmodule CoreaWeb.InvoiceLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Invoices
  alias Corea.Invoices.Invoice

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :invoices, list_invoices())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Invoice")
    |> assign(:invoice, Invoices.get_invoice!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Invoice")
    |> assign(:invoice, %Invoice{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Invoices")
    |> assign(:invoice, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    invoice = Invoices.get_invoice!(id)
    {:ok, _} = Invoices.delete_invoice(invoice)

    {:noreply, assign(socket, :invoices, list_invoices())}
  end

  defp list_invoices do
    Invoices.list_invoices()
  end
end
