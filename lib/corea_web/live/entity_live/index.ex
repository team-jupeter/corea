defmodule CoreaWeb.EntityLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Entities
  alias Corea.Entities.Entity

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :entities, list_entities())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Entity")
    |> assign(:entity, Entities.get_entity!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entity")
    |> assign(:entity, %Entity{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entities")
    |> assign(:entity, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entity = Entities.get_entity!(id)
    {:ok, _} = Entities.delete_entity(entity)

    {:noreply, assign(socket, :entities, list_entities())}
  end

  defp list_entities do
    Entities.list_entities()
  end
end
