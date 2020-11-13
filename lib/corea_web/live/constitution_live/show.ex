defmodule CoreaWeb.ConstitutionLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Constitutions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:constitution, Constitutions.get_constitution!(id))}
  end

  defp page_title(:show), do: "Show Constitution"
  defp page_title(:edit), do: "Edit Constitution"
end
