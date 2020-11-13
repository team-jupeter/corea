defmodule CoreaWeb.TransportLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Transports

  @impl true
  def update(%{transport: transport} = assigns, socket) do
    changeset = Transports.change_transport(transport)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"transport" => transport_params}, socket) do
    changeset =
      socket.assigns.transport
      |> Transports.change_transport(transport_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"transport" => transport_params}, socket) do
    save_transport(socket, socket.assigns.action, transport_params)
  end

  defp save_transport(socket, :edit, transport_params) do
    case Transports.update_transport(socket.assigns.transport, transport_params) do
      {:ok, _transport} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transport updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_transport(socket, :new, transport_params) do
    case Transports.create_transport(transport_params) do
      {:ok, _transport} ->
        {:noreply,
         socket
         |> put_flash(:info, "Transport created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
