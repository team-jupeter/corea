defmodule CoreaWeb.SupulLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Supuls

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:supul, Supuls.get_supul!(id))}
  end

  defp page_title(:show), do: "Show Supul"
  defp page_title(:edit), do: "Edit Supul"
end
