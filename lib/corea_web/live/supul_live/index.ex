defmodule CoreaWeb.SupulLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Supuls
  alias Corea.Supuls.Supul

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :supuls, list_supuls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Supul")
    |> assign(:supul, Supuls.get_supul!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Supul")
    |> assign(:supul, %Supul{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Supuls")
    |> assign(:supul, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    supul = Supuls.get_supul!(id)
    {:ok, _} = Supuls.delete_supul(supul)

    {:noreply, assign(socket, :supuls, list_supuls())}
  end

  defp list_supuls do
    Supuls.list_supuls()
  end
end
