defmodule CoreaWeb.DiseaseControlLive.Index do
  use CoreaWeb, :live_view

  alias Corea.DiseaseControls
  alias Corea.DiseaseControls.DiseaseControl

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :disease_controls, list_disease_controls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Disease control")
    |> assign(:disease_control, DiseaseControls.get_disease_control!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Disease control")
    |> assign(:disease_control, %DiseaseControl{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Disease controls")
    |> assign(:disease_control, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    disease_control = DiseaseControls.get_disease_control!(id)
    {:ok, _} = DiseaseControls.delete_disease_control(disease_control)

    {:noreply, assign(socket, :disease_controls, list_disease_controls())}
  end

  defp list_disease_controls do
    DiseaseControls.list_disease_controls()
  end
end
