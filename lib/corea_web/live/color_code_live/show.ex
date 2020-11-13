defmodule CoreaWeb.ColorCodeLive.Show do
  use CoreaWeb, :live_view

  alias Corea.ColorCodes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:color_code, ColorCodes.get_color_code!(id))}
  end

  defp page_title(:show), do: "Show Color code"
  defp page_title(:edit), do: "Edit Color code"
end
