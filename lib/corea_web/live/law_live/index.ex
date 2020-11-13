defmodule CoreaWeb.LawLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Laws
  alias Corea.Laws.Law

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :laws, list_laws())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Law")
    |> assign(:law, Laws.get_law!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Law")
    |> assign(:law, %Law{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Laws")
    |> assign(:law, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    law = Laws.get_law!(id)
    {:ok, _} = Laws.delete_law(law)

    {:noreply, assign(socket, :laws, list_laws())}
  end

  defp list_laws do
    Laws.list_laws()
  end
end
