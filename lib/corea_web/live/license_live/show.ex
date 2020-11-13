defmodule CoreaWeb.LicenseLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Licenses

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:license, Licenses.get_license!(id))}
  end

  defp page_title(:show), do: "Show License"
  defp page_title(:edit), do: "Edit License"
end
