defmodule CoreaWeb.NationSupulLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.NationSupuls

  @impl true
  def update(%{nation_supul: nation_supul} = assigns, socket) do
    changeset = NationSupuls.change_nation_supul(nation_supul)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"nation_supul" => nation_supul_params}, socket) do
    changeset =
      socket.assigns.nation_supul
      |> NationSupuls.change_nation_supul(nation_supul_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"nation_supul" => nation_supul_params}, socket) do
    save_nation_supul(socket, socket.assigns.action, nation_supul_params)
  end

  defp save_nation_supul(socket, :edit, nation_supul_params) do
    case NationSupuls.update_nation_supul(socket.assigns.nation_supul, nation_supul_params) do
      {:ok, _nation_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nation supul updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_nation_supul(socket, :new, nation_supul_params) do
    case NationSupuls.create_nation_supul(nation_supul_params) do
      {:ok, _nation_supul} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nation supul created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
