defmodule CoreaWeb.GopangLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Gopangs
  alias Corea.Gopangs.Gopang

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :gopangs, list_gopangs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gopang")
    |> assign(:gopang, Gopangs.get_gopang!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gopang")
    |> assign(:gopang, %Gopang{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gopangs")
    |> assign(:gopang, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gopang = Gopangs.get_gopang!(id)
    {:ok, _} = Gopangs.delete_gopang(gopang)

    {:noreply, assign(socket, :gopangs, list_gopangs())}
  end

  defp list_gopangs do
    Gopangs.list_gopangs()
  end
end
