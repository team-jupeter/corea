defmodule CoreaWeb.TaxationLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Taxations

  @impl true
  def update(%{taxation: taxation} = assigns, socket) do
    changeset = Taxations.change_taxation(taxation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"taxation" => taxation_params}, socket) do
    changeset =
      socket.assigns.taxation
      |> Taxations.change_taxation(taxation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"taxation" => taxation_params}, socket) do
    save_taxation(socket, socket.assigns.action, taxation_params)
  end

  defp save_taxation(socket, :edit, taxation_params) do
    case Taxations.update_taxation(socket.assigns.taxation, taxation_params) do
      {:ok, _taxation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Taxation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_taxation(socket, :new, taxation_params) do
    case Taxations.create_taxation(taxation_params) do
      {:ok, _taxation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Taxation created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
