defmodule CoreaWeb.InitiativeLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Initiatives
  alias Corea.Initiatives.Initiative

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :initiatives, list_initiatives())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Initiative")
    |> assign(:initiative, Initiatives.get_initiative!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Initiative")
    |> assign(:initiative, %Initiative{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Initiatives")
    |> assign(:initiative, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    initiative = Initiatives.get_initiative!(id)
    {:ok, _} = Initiatives.delete_initiative(initiative)

    {:noreply, assign(socket, :initiatives, list_initiatives())}
  end

  defp list_initiatives do
    Initiatives.list_initiatives()
  end
end
