defmodule CoreaWeb.TreatmentLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Treatments
  alias Corea.Treatments.Treatment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :treatments, list_treatments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Treatment")
    |> assign(:treatment, Treatments.get_treatment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Treatment")
    |> assign(:treatment, %Treatment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Treatments")
    |> assign(:treatment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    treatment = Treatments.get_treatment!(id)
    {:ok, _} = Treatments.delete_treatment(treatment)

    {:noreply, assign(socket, :treatments, list_treatments())}
  end

  defp list_treatments do
    Treatments.list_treatments()
  end
end
