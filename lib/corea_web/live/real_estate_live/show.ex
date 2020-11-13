defmodule CoreaWeb.RealEstateLive.Show do
  use CoreaWeb, :live_view

  alias Corea.RealEstates

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:real_estate, RealEstates.get_real_estate!(id))}
  end

  defp page_title(:show), do: "Show Real estate"
  defp page_title(:edit), do: "Edit Real estate"
end
