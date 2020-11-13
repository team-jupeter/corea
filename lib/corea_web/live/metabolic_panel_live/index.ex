defmodule CoreaWeb.MetabolicPanelLive.Index do
  use CoreaWeb, :live_view

  alias Corea.MetabolicPanels
  alias Corea.MetabolicPanels.MetabolicPanel

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :metabolic_panels, list_metabolic_panels())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Metabolic panel")
    |> assign(:metabolic_panel, MetabolicPanels.get_metabolic_panel!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Metabolic panel")
    |> assign(:metabolic_panel, %MetabolicPanel{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Metabolic panels")
    |> assign(:metabolic_panel, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    metabolic_panel = MetabolicPanels.get_metabolic_panel!(id)
    {:ok, _} = MetabolicPanels.delete_metabolic_panel(metabolic_panel)

    {:noreply, assign(socket, :metabolic_panels, list_metabolic_panels())}
  end

  defp list_metabolic_panels do
    MetabolicPanels.list_metabolic_panels()
  end
end
