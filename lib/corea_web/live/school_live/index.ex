defmodule CoreaWeb.SchoolLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Schools
  alias Corea.Schools.School

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :schools, list_schools())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit School")
    |> assign(:school, Schools.get_school!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New School")
    |> assign(:school, %School{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Schools")
    |> assign(:school, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    school = Schools.get_school!(id)
    {:ok, _} = Schools.delete_school(school)

    {:noreply, assign(socket, :schools, list_schools())}
  end

  defp list_schools do
    Schools.list_schools()
  end
end
