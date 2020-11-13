defmodule CoreaWeb.OpenhashLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Openhashes
  alias Corea.Openhashes.Openhash

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :openhashes, list_openhashes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Openhash")
    |> assign(:openhash, Openhashes.get_openhash!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Openhash")
    |> assign(:openhash, %Openhash{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Openhashes")
    |> assign(:openhash, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    openhash = Openhashes.get_openhash!(id)
    {:ok, _} = Openhashes.delete_openhash(openhash)

    {:noreply, assign(socket, :openhashes, list_openhashes())}
  end

  defp list_openhashes do
    Openhashes.list_openhashes()
  end
end
