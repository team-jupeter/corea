defmodule CoreaWeb.PatentApplicationLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.PatentApplications

  @impl true
  def update(%{patent_application: patent_application} = assigns, socket) do
    changeset = PatentApplications.change_patent_application(patent_application)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"patent_application" => patent_application_params}, socket) do
    changeset =
      socket.assigns.patent_application
      |> PatentApplications.change_patent_application(patent_application_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"patent_application" => patent_application_params}, socket) do
    save_patent_application(socket, socket.assigns.action, patent_application_params)
  end

  defp save_patent_application(socket, :edit, patent_application_params) do
    case PatentApplications.update_patent_application(socket.assigns.patent_application, patent_application_params) do
      {:ok, _patent_application} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patent application updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_patent_application(socket, :new, patent_application_params) do
    case PatentApplications.create_patent_application(patent_application_params) do
      {:ok, _patent_application} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patent application created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
