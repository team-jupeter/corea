defmodule CoreaWeb.SilLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Sils

  @impl true
  def update(%{sil: sil} = assigns, socket) do
    changeset = Sils.change_sil(sil)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"sil" => sil_params}, socket) do
    changeset =
      socket.assigns.sil
      |> Sils.change_sil(sil_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"sil" => sil_params}, socket) do
    save_sil(socket, socket.assigns.action, sil_params)
  end

  defp save_sil(socket, :edit, sil_params) do
    case Sils.update_sil(socket.assigns.sil, sil_params) do
      {:ok, _sil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sil updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_sil(socket, :new, sil_params) do
    case Sils.create_sil(sil_params) do
      {:ok, _sil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sil created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
