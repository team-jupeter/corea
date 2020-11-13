defmodule CoreaWeb.ReservoirLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Reservoirs
  alias Corea.Reservoirs.Reservoir

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :reservoirs, list_reservoirs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Reservoir")
    |> assign(:reservoir, Reservoirs.get_reservoir!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Reservoir")
    |> assign(:reservoir, %Reservoir{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Reservoirs")
    |> assign(:reservoir, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    reservoir = Reservoirs.get_reservoir!(id)
    {:ok, _} = Reservoirs.delete_reservoir(reservoir)

    {:noreply, assign(socket, :reservoirs, list_reservoirs())}
  end

  defp list_reservoirs do
    Reservoirs.list_reservoirs()
  end
end
