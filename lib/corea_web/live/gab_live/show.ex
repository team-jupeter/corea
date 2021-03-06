defmodule CoreaWeb.GABLive.Show do
  use CoreaWeb, :live_view

  alias Corea.GABs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gab, GABs.get_gab!(id))}
  end

  defp page_title(:show), do: "Show Gab"
  defp page_title(:edit), do: "Edit Gab"
end
