defmodule CoreaWeb.SilLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Sils

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sil, Sils.get_sil!(id))}
  end

  defp page_title(:show), do: "Show Sil"
  defp page_title(:edit), do: "Edit Sil"
end
