defmodule CoreaWeb.PatentLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Patents
  alias Corea.Patents.Patent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :patents, list_patents())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patent")
    |> assign(:patent, Patents.get_patent!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patent")
    |> assign(:patent, %Patent{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patents")
    |> assign(:patent, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patent = Patents.get_patent!(id)
    {:ok, _} = Patents.delete_patent(patent)

    {:noreply, assign(socket, :patents, list_patents())}
  end

  defp list_patents do
    Patents.list_patents()
  end
end
