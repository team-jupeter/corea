defmodule CoreaWeb.GABLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GABs

  @impl true
  def update(%{gab: gab} = assigns, socket) do
    changeset = GABs.change_gab(gab)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gab" => gab_params}, socket) do
    changeset =
      socket.assigns.gab
      |> GABs.change_gab(gab_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gab" => gab_params}, socket) do
    save_gab(socket, socket.assigns.action, gab_params)
  end

  defp save_gab(socket, :edit, gab_params) do
    case GABs.update_gab(socket.assigns.gab, gab_params) do
      {:ok, _gab} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gab(socket, :new, gab_params) do
    case GABs.create_gab(gab_params) do
      {:ok, _gab} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gab created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
