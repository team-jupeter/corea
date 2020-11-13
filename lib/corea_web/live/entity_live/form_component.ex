defmodule CoreaWeb.EntityLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Entities

  @impl true
  def update(%{entity: entity} = assigns, socket) do
    changeset = Entities.change_entity(entity)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"entity" => entity_params}, socket) do
    changeset =
      socket.assigns.entity
      |> Entities.change_entity(entity_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"entity" => entity_params}, socket) do
    save_entity(socket, socket.assigns.action, entity_params)
  end

  defp save_entity(socket, :edit, entity_params) do
    case Entities.update_entity(socket.assigns.entity, entity_params) do
      {:ok, _entity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Entity updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_entity(socket, :new, entity_params) do
    case Entities.create_entity(entity_params) do
      {:ok, _entity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Entity created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
