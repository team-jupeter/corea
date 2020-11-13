defmodule CoreaWeb.T5Live.Show do
  use CoreaWeb, :live_view

  alias Corea.T5s

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t5, T5s.get_t5!(id))}
  end

  defp page_title(:show), do: "Show T5"
  defp page_title(:edit), do: "Edit T5"
end
