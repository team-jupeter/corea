defmodule CoreaWeb.TransportLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Transports
  alias Corea.Transports.Transport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :transports, list_transports())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Transport")
    |> assign(:transport, Transports.get_transport!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Transport")
    |> assign(:transport, %Transport{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Transports")
    |> assign(:transport, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    transport = Transports.get_transport!(id)
    {:ok, _} = Transports.delete_transport(transport)

    {:noreply, assign(socket, :transports, list_transports())}
  end

  defp list_transports do
    Transports.list_transports()
  end
end
