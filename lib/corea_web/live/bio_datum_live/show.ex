defmodule CoreaWeb.BioDatumLive.Show do
  use CoreaWeb, :live_view

  alias Corea.BioData

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bio_datum, BioData.get_bio_datum!(id))}
  end

  defp page_title(:show), do: "Show Bio datum"
  defp page_title(:edit), do: "Edit Bio datum"
end
