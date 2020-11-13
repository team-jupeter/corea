defmodule CoreaWeb.TrafficLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Traffics

  @impl true
  def update(%{traffic: traffic} = assigns, socket) do
    changeset = Traffics.change_traffic(traffic)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"traffic" => traffic_params}, socket) do
    changeset =
      socket.assigns.traffic
      |> Traffics.change_traffic(traffic_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"traffic" => traffic_params}, socket) do
    save_traffic(socket, socket.assigns.action, traffic_params)
  end

  defp save_traffic(socket, :edit, traffic_params) do
    case Traffics.update_traffic(socket.assigns.traffic, traffic_params) do
      {:ok, _traffic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Traffic updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_traffic(socket, :new, traffic_params) do
    case Traffics.create_traffic(traffic_params) do
      {:ok, _traffic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Traffic created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
