defmodule CoreaWeb.PayloadLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Payloads

  @impl true
  def update(%{payload: payload} = assigns, socket) do
    changeset = Payloads.change_payload(payload)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"payload" => payload_params}, socket) do
    changeset =
      socket.assigns.payload
      |> Payloads.change_payload(payload_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"payload" => payload_params}, socket) do
    save_payload(socket, socket.assigns.action, payload_params)
  end

  defp save_payload(socket, :edit, payload_params) do
    case Payloads.update_payload(socket.assigns.payload, payload_params) do
      {:ok, _payload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payload updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_payload(socket, :new, payload_params) do
    case Payloads.create_payload(payload_params) do
      {:ok, _payload} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payload created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
