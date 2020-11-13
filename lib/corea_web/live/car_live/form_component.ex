defmodule CoreaWeb.CarLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Cars

  @impl true
  def update(%{car: car} = assigns, socket) do
    changeset = Cars.change_car(car)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"car" => car_params}, socket) do
    changeset =
      socket.assigns.car
      |> Cars.change_car(car_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"car" => car_params}, socket) do
    save_car(socket, socket.assigns.action, car_params)
  end

  defp save_car(socket, :edit, car_params) do
    case Cars.update_car(socket.assigns.car, car_params) do
      {:ok, _car} ->
        {:noreply,
         socket
         |> put_flash(:info, "Car updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_car(socket, :new, car_params) do
    case Cars.create_car(car_params) do
      {:ok, _car} ->
        {:noreply,
         socket
         |> put_flash(:info, "Car created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
