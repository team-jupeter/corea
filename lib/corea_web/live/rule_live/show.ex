defmodule CoreaWeb.RuleLive.Show do
  use CoreaWeb, :live_view

  alias Corea.Rules

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:rule, Rules.get_rule!(id))}
  end

  defp page_title(:show), do: "Show Rule"
  defp page_title(:edit), do: "Edit Rule"
end
