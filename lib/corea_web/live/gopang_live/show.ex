defmodule CoreaWeb.GopangLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Gopangs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gopang, Gopangs.get_gopang!(id))}
  end

  defp page_title(:show), do: "Show Gopang"
  defp page_title(:edit), do: "Edit Gopang"
end
