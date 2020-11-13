defmodule CoreaWeb.NationLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Nations

  @impl true
  def update(%{nation: nation} = assigns, socket) do
    changeset = Nations.change_nation(nation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"nation" => nation_params}, socket) do
    changeset =
      socket.assigns.nation
      |> Nations.change_nation(nation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"nation" => nation_params}, socket) do
    save_nation(socket, socket.assigns.action, nation_params)
  end

  defp save_nation(socket, :edit, nation_params) do
    case Nations.update_nation(socket.assigns.nation, nation_params) do
      {:ok, _nation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_nation(socket, :new, nation_params) do
    case Nations.create_nation(nation_params) do
      {:ok, _nation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nation created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
