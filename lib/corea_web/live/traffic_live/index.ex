defmodule CoreaWeb.TrafficLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Traffics
  alias Corea.Traffics.Traffic

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :traffics, list_traffics())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Traffic")
    |> assign(:traffic, Traffics.get_traffic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Traffic")
    |> assign(:traffic, %Traffic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Traffics")
    |> assign(:traffic, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    traffic = Traffics.get_traffic!(id)
    {:ok, _} = Traffics.delete_traffic(traffic)

    {:noreply, assign(socket, :traffics, list_traffics())}
  end

  defp list_traffics do
    Traffics.list_traffics()
  end
end
