defmodule CoreaWeb.GPCCodeLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GPCCodes

  @impl true
  def update(%{gpc_code: gpc_code} = assigns, socket) do
    changeset = GPCCodes.change_gpc_code(gpc_code)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gpc_code" => gpc_code_params}, socket) do
    changeset =
      socket.assigns.gpc_code
      |> GPCCodes.change_gpc_code(gpc_code_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gpc_code" => gpc_code_params}, socket) do
    save_gpc_code(socket, socket.assigns.action, gpc_code_params)
  end

  defp save_gpc_code(socket, :edit, gpc_code_params) do
    case GPCCodes.update_gpc_code(socket.assigns.gpc_code, gpc_code_params) do
      {:ok, _gpc_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gpc code updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gpc_code(socket, :new, gpc_code_params) do
    case GPCCodes.create_gpc_code(gpc_code_params) do
      {:ok, _gpc_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gpc code created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
