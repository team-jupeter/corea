defmodule CoreaWeb.NationSupulLive.Show do
  use CoreaWeb, :live_view

  alias Corea.NationSupuls

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:nation_supul, NationSupuls.get_nation_supul!(id))}
  end

  defp page_title(:show), do: "Show Nation supul"
  defp page_title(:edit), do: "Edit Nation supul"
end
