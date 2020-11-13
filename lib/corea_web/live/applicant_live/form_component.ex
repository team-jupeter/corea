defmodule CoreaWeb.ApplicantLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Applicants

  @impl true
  def update(%{applicant: applicant} = assigns, socket) do
    changeset = Applicants.change_applicant(applicant)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"applicant" => applicant_params}, socket) do
    changeset =
      socket.assigns.applicant
      |> Applicants.change_applicant(applicant_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"applicant" => applicant_params}, socket) do
    save_applicant(socket, socket.assigns.action, applicant_params)
  end

  defp save_applicant(socket, :edit, applicant_params) do
    case Applicants.update_applicant(socket.assigns.applicant, applicant_params) do
      {:ok, _applicant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Applicant updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_applicant(socket, :new, applicant_params) do
    case Applicants.create_applicant(applicant_params) do
      {:ok, _applicant} ->
        {:noreply,
         socket
         |> put_flash(:info, "Applicant created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
