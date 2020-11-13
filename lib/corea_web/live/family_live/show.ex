defmodule CoreaWeb.FamilyLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Families

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:family, Families.get_family!(id))}
  end

  defp page_title(:show), do: "Show Family"
  defp page_title(:edit), do: "Edit Family"
end
