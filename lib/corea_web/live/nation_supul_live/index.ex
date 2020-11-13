defmodule CoreaWeb.NationSupulLive.Index do
  use CoreaWeb, :live_view

  alias Corea.NationSupuls
  alias Corea.NationSupuls.NationSupul

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :nation_supuls, list_nation_supuls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Nation supul")
    |> assign(:nation_supul, NationSupuls.get_nation_supul!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Nation supul")
    |> assign(:nation_supul, %NationSupul{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Nation supuls")
    |> assign(:nation_supul, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    nation_supul = NationSupuls.get_nation_supul!(id)
    {:ok, _} = NationSupuls.delete_nation_supul(nation_supul)

    {:noreply, assign(socket, :nation_supuls, list_nation_supuls())}
  end

  defp list_nation_supuls do
    NationSupuls.list_nation_supuls()
  end
end
