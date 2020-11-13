defmodule CoreaWeb.LabLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Labs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:lab, Labs.get_lab!(id))}
  end

  defp page_title(:show), do: "Show Lab"
  defp page_title(:edit), do: "Edit Lab"
end
