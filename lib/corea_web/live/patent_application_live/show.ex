defmodule CoreaWeb.PatentApplicationLive.Show do
  use CoreaWeb, :live_view

  alias Corea.PatentApplications

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:patent_application, PatentApplications.get_patent_application!(id))}
  end

  defp page_title(:show), do: "Show Patent application"
  defp page_title(:edit), do: "Edit Patent application"
end
