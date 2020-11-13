defmodule CoreaWeb.GeoLogLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.GeoLogs

  @impl true
  def update(%{geo_log: geo_log} = assigns, socket) do
    changeset = GeoLogs.change_geo_log(geo_log)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"geo_log" => geo_log_params}, socket) do
    changeset =
      socket.assigns.geo_log
      |> GeoLogs.change_geo_log(geo_log_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"geo_log" => geo_log_params}, socket) do
    save_geo_log(socket, socket.assigns.action, geo_log_params)
  end

  defp save_geo_log(socket, :edit, geo_log_params) do
    case GeoLogs.update_geo_log(socket.assigns.geo_log, geo_log_params) do
      {:ok, _geo_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Geo log updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_geo_log(socket, :new, geo_log_params) do
    case GeoLogs.create_geo_log(geo_log_params) do
      {:ok, _geo_log} ->
        {:noreply,
         socket
         |> put_flash(:info, "Geo log created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
