defmodule CoreaWeb.GlobalSupulLive.Index do
  use CoreaWeb, :live_view

  alias Corea.GlobalSupuls
  alias Corea.GlobalSupuls.GlobalSupul

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :global_supuls, list_global_supuls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Global supul")
    |> assign(:global_supul, GlobalSupuls.get_global_supul!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Global supul")
    |> assign(:global_supul, %GlobalSupul{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Global supuls")
    |> assign(:global_supul, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    global_supul = GlobalSupuls.get_global_supul!(id)
    {:ok, _} = GlobalSupuls.delete_global_supul(global_supul)

    {:noreply, assign(socket, :global_supuls, list_global_supuls())}
  end

  defp list_global_supuls do
    GlobalSupuls.list_global_supuls()
  end
end
