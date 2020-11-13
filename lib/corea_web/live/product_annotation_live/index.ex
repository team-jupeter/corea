defmodule CoreaWeb.ProductAnnotationLive.Index do
  use CoreaWeb, :live_view

  alias Corea.ProductAnnotations
  alias Corea.ProductAnnotations.ProductAnnotation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :product_annotations, list_product_annotations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product annotation")
    |> assign(:product_annotation, ProductAnnotations.get_product_annotation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product annotation")
    |> assign(:product_annotation, %ProductAnnotation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Product annotations")
    |> assign(:product_annotation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product_annotation = ProductAnnotations.get_product_annotation!(id)
    {:ok, _} = ProductAnnotations.delete_product_annotation(product_annotation)

    {:noreply, assign(socket, :product_annotations, list_product_annotations())}
  end

  defp list_product_annotations do
    ProductAnnotations.list_product_annotations()
  end
end
