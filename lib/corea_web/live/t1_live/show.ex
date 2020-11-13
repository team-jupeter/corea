defmodule CoreaWeb.T1Live.Show do
  use CoreaWeb, :live_view

  alias Corea.T1s

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t1, T1s.get_t1!(id))}
  end

  defp page_title(:show), do: "Show T1"
  defp page_title(:edit), do: "Edit T1"
end
