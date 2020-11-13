defmodule CoreaWeb.PayloadArchiveLive.Show do
  use CoreaWeb, :live_view

  alias Corea.PayloadArchives

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:payload_archive, PayloadArchives.get_payload_archive!(id))}
  end

  defp page_title(:show), do: "Show Payload archive"
  defp page_title(:edit), do: "Edit Payload archive"
end
