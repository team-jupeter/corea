defmodule CoreaWeb.TreatmentLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Treatments

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:treatment, Treatments.get_treatment!(id))}
  end

  defp page_title(:show), do: "Show Treatment"
  defp page_title(:edit), do: "Edit Treatment"
end
