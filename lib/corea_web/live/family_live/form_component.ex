defmodule CoreaWeb.FamilyLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Families

  @impl true
  def update(%{family: family} = assigns, socket) do
    changeset = Families.change_family(family)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"family" => family_params}, socket) do
    changeset =
      socket.assigns.family
      |> Families.change_family(family_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"family" => family_params}, socket) do
    save_family(socket, socket.assigns.action, family_params)
  end

  defp save_family(socket, :edit, family_params) do
    case Families.update_family(socket.assigns.family, family_params) do
      {:ok, _family} ->
        {:noreply,
         socket
         |> put_flash(:info, "Family updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_family(socket, :new, family_params) do
    case Families.create_family(family_params) do
      {:ok, _family} ->
        {:noreply,
         socket
         |> put_flash(:info, "Family created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
