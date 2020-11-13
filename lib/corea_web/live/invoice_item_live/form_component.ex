defmodule CoreaWeb.InvoiceItemLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.InvoiceItems

  @impl true
  def update(%{invoice_item: invoice_item} = assigns, socket) do
    changeset = InvoiceItems.change_invoice_item(invoice_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"invoice_item" => invoice_item_params}, socket) do
    changeset =
      socket.assigns.invoice_item
      |> InvoiceItems.change_invoice_item(invoice_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"invoice_item" => invoice_item_params}, socket) do
    save_invoice_item(socket, socket.assigns.action, invoice_item_params)
  end

  defp save_invoice_item(socket, :edit, invoice_item_params) do
    case InvoiceItems.update_invoice_item(socket.assigns.invoice_item, invoice_item_params) do
      {:ok, _invoice_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Invoice item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_invoice_item(socket, :new, invoice_item_params) do
    case InvoiceItems.create_invoice_item(invoice_item_params) do
      {:ok, _invoice_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Invoice item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
