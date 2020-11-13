defmodule CoreaWeb.VideoLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Videos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:video, Videos.get_video!(id))}
  end

  defp page_title(:show), do: "Show Video"
  defp page_title(:edit), do: "Edit Video"
end
