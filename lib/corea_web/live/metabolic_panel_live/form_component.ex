defmodule CoreaWeb.MetabolicPanelLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.MetabolicPanels

  @impl true
  def update(%{metabolic_panel: metabolic_panel} = assigns, socket) do
    changeset = MetabolicPanels.change_metabolic_panel(metabolic_panel)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"metabolic_panel" => metabolic_panel_params}, socket) do
    changeset =
      socket.assigns.metabolic_panel
      |> MetabolicPanels.change_metabolic_panel(metabolic_panel_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"metabolic_panel" => metabolic_panel_params}, socket) do
    save_metabolic_panel(socket, socket.assigns.action, metabolic_panel_params)
  end

  defp save_metabolic_panel(socket, :edit, metabolic_panel_params) do
    case MetabolicPanels.update_metabolic_panel(socket.assigns.metabolic_panel, metabolic_panel_params) do
      {:ok, _metabolic_panel} ->
        {:noreply,
         socket
         |> put_flash(:info, "Metabolic panel updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_metabolic_panel(socket, :new, metabolic_panel_params) do
    case MetabolicPanels.create_metabolic_panel(metabolic_panel_params) do
      {:ok, _metabolic_panel} ->
        {:noreply,
         socket
         |> put_flash(:info, "Metabolic panel created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
