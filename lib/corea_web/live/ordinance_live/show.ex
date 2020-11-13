defmodule CoreaWeb.OrdinanceLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Ordinances

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ordinance, Ordinances.get_ordinance!(id))}
  end

  defp page_title(:show), do: "Show Ordinance"
  defp page_title(:edit), do: "Edit Ordinance"
end
