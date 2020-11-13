defmodule CoreaWeb.PoliceLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Polices

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:police, Polices.get_police!(id))}
  end

  defp page_title(:show), do: "Show Police"
  defp page_title(:edit), do: "Edit Police"
end
