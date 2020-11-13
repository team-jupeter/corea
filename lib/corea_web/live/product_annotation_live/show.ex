defmodule CoreaWeb.ProductAnnotationLive.Show do
  use CoreaWeb, :live_view

  alias Corea.ProductAnnotations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product_annotation, ProductAnnotations.get_product_annotation!(id))}
  end

  defp page_title(:show), do: "Show Product annotation"
  defp page_title(:edit), do: "Edit Product annotation"
end
