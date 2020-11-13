defmodule CoreaWeb.T1Live.Index do
  use CoreaWeb, :live_view

  alias Corea.T1s
  alias Corea.T1s.T1

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t1s, list_t1s())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T1")
    |> assign(:t1, T1s.get_t1!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T1")
    |> assign(:t1, %T1{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T1s")
    |> assign(:t1, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t1 = T1s.get_t1!(id)
    {:ok, _} = T1s.delete_t1(t1)

    {:noreply, assign(socket, :t1s, list_t1s())}
  end

  defp list_t1s do
    T1s.list_t1s()
  end
end
