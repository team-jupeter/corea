defmodule CoreaWeb.MentorLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Mentors
  alias Corea.Mentors.Mentor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :mentors, list_mentors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mentor")
    |> assign(:mentor, Mentors.get_mentor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mentor")
    |> assign(:mentor, %Mentor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mentors")
    |> assign(:mentor, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mentor = Mentors.get_mentor!(id)
    {:ok, _} = Mentors.delete_mentor(mentor)

    {:noreply, assign(socket, :mentors, list_mentors())}
  end

  defp list_mentors do
    Mentors.list_mentors()
  end
end
