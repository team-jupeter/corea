defmodule CoreaWeb.PrescriptionLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Prescriptions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:prescription, Prescriptions.get_prescription!(id))}
  end

  defp page_title(:show), do: "Show Prescription"
  defp page_title(:edit), do: "Edit Prescription"
end
