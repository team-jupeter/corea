defmodule CoreaWeb.RealEstateLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.RealEstates

  @impl true
  def update(%{real_estate: real_estate} = assigns, socket) do
    changeset = RealEstates.change_real_estate(real_estate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"real_estate" => real_estate_params}, socket) do
    changeset =
      socket.assigns.real_estate
      |> RealEstates.change_real_estate(real_estate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"real_estate" => real_estate_params}, socket) do
    save_real_estate(socket, socket.assigns.action, real_estate_params)
  end

  defp save_real_estate(socket, :edit, real_estate_params) do
    case RealEstates.update_real_estate(socket.assigns.real_estate, real_estate_params) do
      {:ok, _real_estate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Real estate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_real_estate(socket, :new, real_estate_params) do
    case RealEstates.create_real_estate(real_estate_params) do
      {:ok, _real_estate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Real estate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
