defmodule CoreaWeb.InitiativeLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Initiatives

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:initiative, Initiatives.get_initiative!(id))}
  end

  defp page_title(:show), do: "Show Initiative"
  defp page_title(:edit), do: "Edit Initiative"
end
