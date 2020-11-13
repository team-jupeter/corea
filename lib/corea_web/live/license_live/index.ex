defmodule CoreaWeb.LicenseLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Licenses
  alias Corea.Licenses.License

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :licenses, list_licenses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit License")
    |> assign(:license, Licenses.get_license!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New License")
    |> assign(:license, %License{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Licenses")
    |> assign(:license, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    license = Licenses.get_license!(id)
    {:ok, _} = Licenses.delete_license(license)

    {:noreply, assign(socket, :licenses, list_licenses())}
  end

  defp list_licenses do
    Licenses.list_licenses()
  end
end
