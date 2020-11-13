defmodule CoreaWeb.DiseaseControlLive.Show do
  use CoreaWeb, :live_view

  alias Corea.DiseaseControls

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:disease_control, DiseaseControls.get_disease_control!(id))}
  end

  defp page_title(:show), do: "Show Disease control"
  defp page_title(:edit), do: "Edit Disease control"
end
