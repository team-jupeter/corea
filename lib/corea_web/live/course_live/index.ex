defmodule CoreaWeb.CourseLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Courses
  alias Corea.Courses.Course

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :courses, list_courses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Course")
    |> assign(:course, Courses.get_course!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Course")
    |> assign(:course, %Course{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Courses")
    |> assign(:course, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    course = Courses.get_course!(id)
    {:ok, _} = Courses.delete_course(course)

    {:noreply, assign(socket, :courses, list_courses())}
  end

  defp list_courses do
    Courses.list_courses()
  end
end
