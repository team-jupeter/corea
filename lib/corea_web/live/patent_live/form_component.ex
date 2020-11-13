defmodule CoreaWeb.PatentLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Patents

  @impl true
  def update(%{patent: patent} = assigns, socket) do
    changeset = Patents.change_patent(patent)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"patent" => patent_params}, socket) do
    changeset =
      socket.assigns.patent
      |> Patents.change_patent(patent_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"patent" => patent_params}, socket) do
    save_patent(socket, socket.assigns.action, patent_params)
  end

  defp save_patent(socket, :edit, patent_params) do
    case Patents.update_patent(socket.assigns.patent, patent_params) do
      {:ok, _patent} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patent updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_patent(socket, :new, patent_params) do
    case Patents.create_patent(patent_params) do
      {:ok, _patent} ->
        {:noreply,
         socket
         |> put_flash(:info, "Patent created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
