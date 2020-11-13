defmodule CoreaWeb.ProductAnnotationLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.ProductAnnotations

  @impl true
  def update(%{product_annotation: product_annotation} = assigns, socket) do
    changeset = ProductAnnotations.change_product_annotation(product_annotation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"product_annotation" => product_annotation_params}, socket) do
    changeset =
      socket.assigns.product_annotation
      |> ProductAnnotations.change_product_annotation(product_annotation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product_annotation" => product_annotation_params}, socket) do
    save_product_annotation(socket, socket.assigns.action, product_annotation_params)
  end

  defp save_product_annotation(socket, :edit, product_annotation_params) do
    case ProductAnnotations.update_product_annotation(socket.assigns.product_annotation, product_annotation_params) do
      {:ok, _product_annotation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product annotation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product_annotation(socket, :new, product_annotation_params) do
    case ProductAnnotations.create_product_annotation(product_annotation_params) do
      {:ok, _product_annotation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product annotation created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
