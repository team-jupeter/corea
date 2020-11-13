defmodule CoreaWeb.LabLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Labs
  alias Corea.Labs.Lab

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :labs, list_labs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Lab")
    |> assign(:lab, Labs.get_lab!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Lab")
    |> assign(:lab, %Lab{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Labs")
    |> assign(:lab, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    lab = Labs.get_lab!(id)
    {:ok, _} = Labs.delete_lab(lab)

    {:noreply, assign(socket, :labs, list_labs())}
  end

  defp list_labs do
    Labs.list_labs()
  end
end
