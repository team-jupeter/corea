defmodule CoreaWeb.DiagnosisLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Diagnoses
  alias Corea.Diagnoses.Diagnosis

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :diagnoses, list_diagnoses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Diagnosis")
    |> assign(:diagnosis, Diagnoses.get_diagnosis!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Diagnosis")
    |> assign(:diagnosis, %Diagnosis{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Diagnoses")
    |> assign(:diagnosis, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    diagnosis = Diagnoses.get_diagnosis!(id)
    {:ok, _} = Diagnoses.delete_diagnosis(diagnosis)

    {:noreply, assign(socket, :diagnoses, list_diagnoses())}
  end

  defp list_diagnoses do
    Diagnoses.list_diagnoses()
  end
end
