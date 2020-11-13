defmodule CoreaWeb.PatentApplicationLive.Index do
  use CoreaWeb, :live_view

  alias Corea.PatentApplications
  alias Corea.PatentApplications.PatentApplication

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :patent_applications, list_patent_applications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Patent application")
    |> assign(:patent_application, PatentApplications.get_patent_application!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Patent application")
    |> assign(:patent_application, %PatentApplication{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Patent applications")
    |> assign(:patent_application, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    patent_application = PatentApplications.get_patent_application!(id)
    {:ok, _} = PatentApplications.delete_patent_application(patent_application)

    {:noreply, assign(socket, :patent_applications, list_patent_applications())}
  end

  defp list_patent_applications do
    PatentApplications.list_patent_applications()
  end
end
