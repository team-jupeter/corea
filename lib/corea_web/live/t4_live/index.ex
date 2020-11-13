defmodule CoreaWeb.T4Live.Index do
  use CoreaWeb, :live_view

  alias Corea.T4s
  alias Corea.T4s.T4

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t4s, list_t4s())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T4")
    |> assign(:t4, T4s.get_t4!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T4")
    |> assign(:t4, %T4{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T4s")
    |> assign(:t4, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t4 = T4s.get_t4!(id)
    {:ok, _} = T4s.delete_t4(t4)

    {:noreply, assign(socket, :t4s, list_t4s())}
  end

  defp list_t4s do
    T4s.list_t4s()
  end
end
