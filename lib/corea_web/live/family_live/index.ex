defmodule CoreaWeb.FamilyLive.Index do
  use CoreaWeb, :live_view

  alias Corea.Families
  alias Corea.Families.Family

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :families, list_families())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Family")
    |> assign(:family, Families.get_family!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Family")
    |> assign(:family, %Family{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Families")
    |> assign(:family, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    family = Families.get_family!(id)
    {:ok, _} = Families.delete_family(family)

    {:noreply, assign(socket, :families, list_families())}
  end

  defp list_families do
    Families.list_families()
  end
end
