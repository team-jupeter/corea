defmodule CoreaWeb.ColorCodeLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.ColorCodes

  @impl true
  def update(%{color_code: color_code} = assigns, socket) do
    changeset = ColorCodes.change_color_code(color_code)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"color_code" => color_code_params}, socket) do
    changeset =
      socket.assigns.color_code
      |> ColorCodes.change_color_code(color_code_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"color_code" => color_code_params}, socket) do
    save_color_code(socket, socket.assigns.action, color_code_params)
  end

  defp save_color_code(socket, :edit, color_code_params) do
    case ColorCodes.update_color_code(socket.assigns.color_code, color_code_params) do
      {:ok, _color_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Color code updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_color_code(socket, :new, color_code_params) do
    case ColorCodes.create_color_code(color_code_params) do
      {:ok, _color_code} ->
        {:noreply,
         socket
         |> put_flash(:info, "Color code created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
