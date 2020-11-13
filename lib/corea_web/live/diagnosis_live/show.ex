defmodule CoreaWeb.DiagnosisLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Diagnoses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:diagnosis, Diagnoses.get_diagnosis!(id))}
  end

  defp page_title(:show), do: "Show Diagnosis"
  defp page_title(:edit), do: "Edit Diagnosis"
end
