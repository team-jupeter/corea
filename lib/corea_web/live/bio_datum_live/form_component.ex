defmodule CoreaWeb.BioDatumLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.BioData

  @impl true
  def update(%{bio_datum: bio_datum} = assigns, socket) do
    changeset = BioData.change_bio_datum(bio_datum)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"bio_datum" => bio_datum_params}, socket) do
    changeset =
      socket.assigns.bio_datum
      |> BioData.change_bio_datum(bio_datum_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"bio_datum" => bio_datum_params}, socket) do
    save_bio_datum(socket, socket.assigns.action, bio_datum_params)
  end

  defp save_bio_datum(socket, :edit, bio_datum_params) do
    case BioData.update_bio_datum(socket.assigns.bio_datum, bio_datum_params) do
      {:ok, _bio_datum} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bio datum updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_bio_datum(socket, :new, bio_datum_params) do
    case BioData.create_bio_datum(bio_datum_params) do
      {:ok, _bio_datum} ->
        {:noreply,
         socket
         |> put_flash(:info, "Bio datum created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
