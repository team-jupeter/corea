defmodule CoreaWeb.TransferLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Transfers

  @impl true
  def update(%{transfer: transfer} = assigns, socket) do
    changeset = Transfers.change_transfer(transfer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"transfer" => transfer_params}, socket) do
    changeset =
      socket.assigns.transfer
      |> Transfers.change_transfer(transfer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"transfer" => transfer_params}, socket) do
    save_transfer(socket, socket.assigns.action, transfer_params)
  end

  defp save_transfer(socket, :edit, transfer_params) do
    case Transfers.update_transfer(socket.assigns.transfer, transfer_params) do
      {:ok, _transfer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transfer updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_transfer(socket, :new, transfer_params) do
    case Transfers.create_transfer(transfer_params) do
      {:ok, _transfer} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transfer created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
