defmodule CoreaWeb.OpenhashLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Openhashes

  @impl true
  def update(%{openhash: openhash} = assigns, socket) do
    changeset = Openhashes.change_openhash(openhash)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"openhash" => openhash_params}, socket) do
    changeset =
      socket.assigns.openhash
      |> Openhashes.change_openhash(openhash_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"openhash" => openhash_params}, socket) do
    save_openhash(socket, socket.assigns.action, openhash_params)
  end

  defp save_openhash(socket, :edit, openhash_params) do
    case Openhashes.update_openhash(socket.assigns.openhash, openhash_params) do
      {:ok, _openhash} ->
        {:noreply,
         socket
         |> put_flash(:info, "Openhash updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_openhash(socket, :new, openhash_params) do
    case Openhashes.create_openhash(openhash_params) do
      {:ok, _openhash} ->
        {:noreply,
         socket
         |> put_flash(:info, "Openhash created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
