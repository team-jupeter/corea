defmodule CoreaWeb.T3Live.Index do
  use CoreaWeb, :live_view

  alias Corea.T3s
  alias Corea.T3s.T3

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t3s, list_t3s())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T3")
    |> assign(:t3, T3s.get_t3!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T3")
    |> assign(:t3, %T3{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T3s")
    |> assign(:t3, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t3 = T3s.get_t3!(id)
    {:ok, _} = T3s.delete_t3(t3)

    {:noreply, assign(socket, :t3s, list_t3s())}
  end

  defp list_t3s do
    T3s.list_t3s()
  end
end
