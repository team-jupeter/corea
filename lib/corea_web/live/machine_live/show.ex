defmodule CoreaWeb.MachineLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Machines

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:machine, Machines.get_machine!(id))}
  end

  defp page_title(:show), do: "Show Machine"
  defp page_title(:edit), do: "Edit Machine"
end
