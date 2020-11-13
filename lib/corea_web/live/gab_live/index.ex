defmodule CoreaWeb.GABLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GABs
  alias Corea.GABs.GAB

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gabs, list_gabs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gab")
    |> assign(:gab, GABs.get_gab!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gab")
    |> assign(:gab, %GAB{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gabs")
    |> assign(:gab, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gab = GABs.get_gab!(id)
    {:ok, _} = GABs.delete_gab(gab)

    {:noreply, assign(socket, :gabs, list_gabs())}
  end

  defp list_gabs do
    GABs.list_gabs()
  end
end
