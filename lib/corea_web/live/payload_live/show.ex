defmodule CoreaWeb.PayloadLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Payloads

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:payload, Payloads.get_payload!(id))}
  end

  defp page_title(:show), do: "Show Payload"
  defp page_title(:edit), do: "Edit Payload"
end
