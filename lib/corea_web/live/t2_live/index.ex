defmodule CoreaWeb.T2Live.Index do
  use CoreaWeb, :live_view

  alias Corea.T2s
  alias Corea.T2s.T2

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t2s, list_t2s())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T2")
    |> assign(:t2, T2s.get_t2!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T2")
    |> assign(:t2, %T2{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T2s")
    |> assign(:t2, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t2 = T2s.get_t2!(id)
    {:ok, _} = T2s.delete_t2(t2)

    {:noreply, assign(socket, :t2s, list_t2s())}
  end

  defp list_t2s do
    T2s.list_t2s()
  end
end
