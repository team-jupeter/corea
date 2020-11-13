defmodule CoreaWeb.TaxationLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Taxations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:taxation, Taxations.get_taxation!(id))}
  end

  defp page_title(:show), do: "Show Taxation"
  defp page_title(:edit), do: "Edit Taxation"
end
