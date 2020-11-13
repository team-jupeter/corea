defmodule CoreaWeb.InitiativeLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Initiatives

  @impl true
  def update(%{initiative: initiative} = assigns, socket) do
    changeset = Initiatives.change_initiative(initiative)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"initiative" => initiative_params}, socket) do
    changeset =
      socket.assigns.initiative
      |> Initiatives.change_initiative(initiative_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"initiative" => initiative_params}, socket) do
    save_initiative(socket, socket.assigns.action, initiative_params)
  end

  defp save_initiative(socket, :edit, initiative_params) do
    case Initiatives.update_initiative(socket.assigns.initiative, initiative_params) do
      {:ok, _initiative} ->
        {:noreply,
         socket
         |> put_flash(:info, "Initiative updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_initiative(socket, :new, initiative_params) do
    case Initiatives.create_initiative(initiative_params) do
      {:ok, _initiative} ->
        {:noreply,
         socket
         |> put_flash(:info, "Initiative created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
