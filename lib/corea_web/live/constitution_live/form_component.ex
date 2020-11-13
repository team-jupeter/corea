defmodule CoreaWeb.ConstitutionLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Constitutions

  @impl true
  def update(%{constitution: constitution} = assigns, socket) do
    changeset = Constitutions.change_constitution(constitution)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"constitution" => constitution_params}, socket) do
    changeset =
      socket.assigns.constitution
      |> Constitutions.change_constitution(constitution_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"constitution" => constitution_params}, socket) do
    save_constitution(socket, socket.assigns.action, constitution_params)
  end

  defp save_constitution(socket, :edit, constitution_params) do
    case Constitutions.update_constitution(socket.assigns.constitution, constitution_params) do
      {:ok, _constitution} ->
        {:noreply,
         socket
         |> put_flash(:info, "Constitution updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_constitution(socket, :new, constitution_params) do
    case Constitutions.create_constitution(constitution_params) do
      {:ok, _constitution} ->
        {:noreply,
         socket
         |> put_flash(:info, "Constitution created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
