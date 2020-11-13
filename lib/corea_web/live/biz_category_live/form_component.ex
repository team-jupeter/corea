defmodule CoreaWeb.BizCategoryLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.BizCategories

  @impl true
  def update(%{biz_category: biz_category} = assigns, socket) do
    changeset = BizCategories.change_biz_category(biz_category)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"biz_category" => biz_category_params}, socket) do
    changeset =
      socket.assigns.biz_category
      |> BizCategories.change_biz_category(biz_category_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"biz_category" => biz_category_params}, socket) do
    save_biz_category(socket, socket.assigns.action, biz_category_params)
  end

  defp save_biz_category(socket, :edit, biz_category_params) do
    case BizCategories.update_biz_category(socket.assigns.biz_category, biz_category_params) do
      {:ok, _biz_category} ->
        {:noreply,
         socket
         |> put_flash(:info, "Biz category updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_biz_category(socket, :new, biz_category_params) do
    case BizCategories.create_biz_category(biz_category_params) do
      {:ok, _biz_category} ->
        {:noreply,
         socket
         |> put_flash(:info, "Biz category created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
