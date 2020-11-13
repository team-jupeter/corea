defmodule CoreaWeb.LawLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Laws

  @impl true
  def update(%{law: law} = assigns, socket) do
    changeset = Laws.change_law(law)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"law" => law_params}, socket) do
    changeset =
      socket.assigns.law
      |> Laws.change_law(law_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"law" => law_params}, socket) do
    save_law(socket, socket.assigns.action, law_params)
  end

  defp save_law(socket, :edit, law_params) do
    case Laws.update_law(socket.assigns.law, law_params) do
      {:ok, _law} ->
        {:noreply,
         socket
         |> put_flash(:info, "Law updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_law(socket, :new, law_params) do
    case Laws.create_law(law_params) do
      {:ok, _law} ->
        {:noreply,
         socket
         |> put_flash(:info, "Law created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
