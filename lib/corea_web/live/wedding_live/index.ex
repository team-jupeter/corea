defmodule CoreaWeb.WeddingLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Weddings
  alias Corea.Weddings.Wedding

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :weddings, list_weddings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Wedding")
    |> assign(:wedding, Weddings.get_wedding!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Wedding")
    |> assign(:wedding, %Wedding{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Weddings")
    |> assign(:wedding, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    wedding = Weddings.get_wedding!(id)
    {:ok, _} = Weddings.delete_wedding(wedding)

    {:noreply, assign(socket, :weddings, list_weddings())}
  end

  defp list_weddings do
    Weddings.list_weddings()
  end
end
