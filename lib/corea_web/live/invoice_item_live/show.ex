defmodule CoreaWeb.InvoiceItemLive.Show do
  use CoreaWeb, :live_view

  alias Corea.InvoiceItems

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:invoice_item, InvoiceItems.get_invoice_item!(id))}
  end

  defp page_title(:show), do: "Show Invoice item"
  defp page_title(:edit), do: "Edit Invoice item"
end
