defmodule CoreaWeb.CertificateLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Certificates

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:certificate, Certificates.get_certificate!(id))}
  end

  defp page_title(:show), do: "Show Certificate"
  defp page_title(:edit), do: "Edit Certificate"
end
