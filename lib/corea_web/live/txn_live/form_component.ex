defmodule CoreaWeb.TxnLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Txns

  @impl true
  def update(%{txn: txn} = assigns, socket) do
    changeset = Txns.change_txn(txn)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"txn" => txn_params}, socket) do
    changeset =
      socket.assigns.txn
      |> Txns.change_txn(txn_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"txn" => txn_params}, socket) do
    save_txn(socket, socket.assigns.action, txn_params)
  end

  defp save_txn(socket, :edit, txn_params) do
    case Txns.update_txn(socket.assigns.txn, txn_params) do
      {:ok, _txn} ->
        {:noreply,
         socket
         |> put_flash(:info, "Txn updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_txn(socket, :new, txn_params) do
    case Txns.create_txn(txn_params) do
      {:ok, _txn} ->
        {:noreply,
         socket
         |> put_flash(:info, "Txn created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
