defmodule CoreaWeb.ApplicantLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Applicants

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:applicant, Applicants.get_applicant!(id))}
  end

  defp page_title(:show), do: "Show Applicant"
  defp page_title(:edit), do: "Edit Applicant"
end
