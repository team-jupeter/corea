defmodule CoreaWeb.NationLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Nations
  alias Corea.Nations.Nation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :nations, list_nations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Nation")
    |> assign(:nation, Nations.get_nation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Nation")
    |> assign(:nation, %Nation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Nations")
    |> assign(:nation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    nation = Nations.get_nation!(id)
    {:ok, _} = Nations.delete_nation(nation)

    {:noreply, assign(socket, :nations, list_nations())}
  end

  defp list_nations do
    Nations.list_nations()
  end
end
