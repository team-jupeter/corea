defmodule CoreaWeb.SilLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Sils
  alias Corea.Sils.Sil

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :sils, list_sils())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sil")
    |> assign(:sil, Sils.get_sil!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sil")
    |> assign(:sil, %Sil{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sils")
    |> assign(:sil, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sil = Sils.get_sil!(id)
    {:ok, _} = Sils.delete_sil(sil)

    {:noreply, assign(socket, :sils, list_sils())}
  end

  defp list_sils do
    Sils.list_sils()
  end
end
