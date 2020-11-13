defmodule CoreaWeb.MachineLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Machines

  @impl true
  def update(%{machine: machine} = assigns, socket) do
    changeset = Machines.change_machine(machine)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"machine" => machine_params}, socket) do
    changeset =
      socket.assigns.machine
      |> Machines.change_machine(machine_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"machine" => machine_params}, socket) do
    save_machine(socket, socket.assigns.action, machine_params)
  end

  defp save_machine(socket, :edit, machine_params) do
    case Machines.update_machine(socket.assigns.machine, machine_params) do
      {:ok, _machine} ->
        {:noreply,
         socket
         |> put_flash(:info, "Machine updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_machine(socket, :new, machine_params) do
    case Machines.create_machine(machine_params) do
      {:ok, _machine} ->
        {:noreply,
         socket
         |> put_flash(:info, "Machine created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
