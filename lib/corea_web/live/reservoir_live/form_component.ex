defmodule CoreaWeb.ReservoirLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Reservoirs

  @impl true
  def update(%{reservoir: reservoir} = assigns, socket) do
    changeset = Reservoirs.change_reservoir(reservoir)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"reservoir" => reservoir_params}, socket) do
    changeset =
      socket.assigns.reservoir
      |> Reservoirs.change_reservoir(reservoir_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"reservoir" => reservoir_params}, socket) do
    save_reservoir(socket, socket.assigns.action, reservoir_params)
  end

  defp save_reservoir(socket, :edit, reservoir_params) do
    case Reservoirs.update_reservoir(socket.assigns.reservoir, reservoir_params) do
      {:ok, _reservoir} ->
        {:noreply,
         socket
         |> put_flash(:info, "Reservoir updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_reservoir(socket, :new, reservoir_params) do
    case Reservoirs.create_reservoir(reservoir_params) do
      {:ok, _reservoir} ->
        {:noreply,
         socket
         |> put_flash(:info, "Reservoir created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
