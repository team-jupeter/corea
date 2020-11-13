defmodule CoreaWeb.OrdinanceLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Ordinances

  @impl true
  def update(%{ordinance: ordinance} = assigns, socket) do
    changeset = Ordinances.change_ordinance(ordinance)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ordinance" => ordinance_params}, socket) do
    changeset =
      socket.assigns.ordinance
      |> Ordinances.change_ordinance(ordinance_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ordinance" => ordinance_params}, socket) do
    save_ordinance(socket, socket.assigns.action, ordinance_params)
  end

  defp save_ordinance(socket, :edit, ordinance_params) do
    case Ordinances.update_ordinance(socket.assigns.ordinance, ordinance_params) do
      {:ok, _ordinance} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ordinance updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ordinance(socket, :new, ordinance_params) do
    case Ordinances.create_ordinance(ordinance_params) do
      {:ok, _ordinance} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ordinance created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
