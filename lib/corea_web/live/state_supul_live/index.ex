defmodule CoreaWeb.StateSupulLive.Index do
  use CoreaWeb, :live_view

  alias Corea.StateSupuls
  alias Corea.StateSupuls.StateSupul

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :state_supuls, list_state_supuls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit State supul")
    |> assign(:state_supul, StateSupuls.get_state_supul!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New State supul")
    |> assign(:state_supul, %StateSupul{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing State supuls")
    |> assign(:state_supul, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    state_supul = StateSupuls.get_state_supul!(id)
    {:ok, _} = StateSupuls.delete_state_supul(state_supul)

    {:noreply, assign(socket, :state_supuls, list_state_supuls())}
  end

  defp list_state_supuls do
    StateSupuls.list_state_supuls()
  end
end
