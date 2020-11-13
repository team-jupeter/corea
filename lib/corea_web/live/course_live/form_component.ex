defmodule CoreaWeb.CourseLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Courses

  @impl true
  def update(%{course: course} = assigns, socket) do
    changeset = Courses.change_course(course)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"course" => course_params}, socket) do
    changeset =
      socket.assigns.course
      |> Courses.change_course(course_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"course" => course_params}, socket) do
    save_course(socket, socket.assigns.action, course_params)
  end

  defp save_course(socket, :edit, course_params) do
    case Courses.update_course(socket.assigns.course, course_params) do
      {:ok, _course} ->
        {:noreply,
         socket
         |> put_flash(:info, "Course updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_course(socket, :new, course_params) do
    case Courses.create_course(course_params) do
      {:ok, _course} ->
        {:noreply,
         socket
         |> put_flash(:info, "Course created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
