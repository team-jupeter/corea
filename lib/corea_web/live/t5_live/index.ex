defmodule CoreaWeb.T5Live.Index do
  use CoreaWeb, :live_view

  alias Corea.T5s
  alias Corea.T5s.T5

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :t5s, list_t5s())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T5")
    |> assign(:t5, T5s.get_t5!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T5")
    |> assign(:t5, %T5{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing T5s")
    |> assign(:t5, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t5 = T5s.get_t5!(id)
    {:ok, _} = T5s.delete_t5(t5)

    {:noreply, assign(socket, :t5s, list_t5s())}
  end

  defp list_t5s do
    T5s.list_t5s()
  end
end
