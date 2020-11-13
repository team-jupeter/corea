defmodule CoreaWeb.GopangLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Gopangs

  @impl true
  def update(%{gopang: gopang} = assigns, socket) do
    changeset = Gopangs.change_gopang(gopang)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gopang" => gopang_params}, socket) do
    changeset =
      socket.assigns.gopang
      |> Gopangs.change_gopang(gopang_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gopang" => gopang_params}, socket) do
    save_gopang(socket, socket.assigns.action, gopang_params)
  end

  defp save_gopang(socket, :edit, gopang_params) do
    case Gopangs.update_gopang(socket.assigns.gopang, gopang_params) do
      {:ok, _gopang} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gopang updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gopang(socket, :new, gopang_params) do
    case Gopangs.create_gopang(gopang_params) do
      {:ok, _gopang} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gopang created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
