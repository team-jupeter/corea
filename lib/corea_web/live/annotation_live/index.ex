defmodule CoreaWeb.AnnotationLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Annotations
  alias Corea.Annotations.Annotation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :annotations, list_annotations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Annotation")
    |> assign(:annotation, Annotations.get_annotation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Annotation")
    |> assign(:annotation, %Annotation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Annotations")
    |> assign(:annotation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    annotation = Annotations.get_annotation!(id)
    {:ok, _} = Annotations.delete_annotation(annotation)

    {:noreply, assign(socket, :annotations, list_annotations())}
  end

  defp list_annotations do
    Annotations.list_annotations()
  end
end
