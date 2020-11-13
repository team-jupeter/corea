defmodule CoreaWeb.ConstitutionLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Constitutions
  alias Corea.Constitutions.Constitution

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :constitutions, list_constitutions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Constitution")
    |> assign(:constitution, Constitutions.get_constitution!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Constitution")
    |> assign(:constitution, %Constitution{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Constitutions")
    |> assign(:constitution, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    constitution = Constitutions.get_constitution!(id)
    {:ok, _} = Constitutions.delete_constitution(constitution)

    {:noreply, assign(socket, :constitutions, list_constitutions())}
  end

  defp list_constitutions do
    Constitutions.list_constitutions()
  end
end
