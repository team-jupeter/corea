defmodule CoreaWeb.ApplicantLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Applicants
  alias Corea.Applicants.Applicant

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :applicants, list_applicants())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Applicant")
    |> assign(:applicant, Applicants.get_applicant!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Applicant")
    |> assign(:applicant, %Applicant{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Applicants")
    |> assign(:applicant, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    applicant = Applicants.get_applicant!(id)
    {:ok, _} = Applicants.delete_applicant(applicant)

    {:noreply, assign(socket, :applicants, list_applicants())}
  end

  defp list_applicants do
    Applicants.list_applicants()
  end
end
