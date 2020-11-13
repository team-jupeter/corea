defmodule CoreaWeb.GPCCodeLive.Show do
  use CoreaWeb, :live_view

  alias Corea.GPCCodes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gpc_code, GPCCodes.get_gpc_code!(id))}
  end

  defp page_title(:show), do: "Show Gpc code"
  defp page_title(:edit), do: "Edit Gpc code"
end
