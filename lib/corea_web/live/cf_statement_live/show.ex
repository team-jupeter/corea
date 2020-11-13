defmodule CoreaWeb.CFStatementLive.Show do
  use CoreaWeb, :live_view

  alias Corea.CFStatements

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cf_statement, CFStatements.get_cf_statement!(id))}
  end

  defp page_title(:show), do: "Show Cf statement"
  defp page_title(:edit), do: "Edit Cf statement"
end
