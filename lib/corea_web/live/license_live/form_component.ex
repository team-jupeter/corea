defmodule CoreaWeb.LicenseLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Licenses

  @impl true
  def update(%{license: license} = assigns, socket) do
    changeset = Licenses.change_license(license)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"license" => license_params}, socket) do
    changeset =
      socket.assigns.license
      |> Licenses.change_license(license_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"license" => license_params}, socket) do
    save_license(socket, socket.assigns.action, license_params)
  end

  defp save_license(socket, :edit, license_params) do
    case Licenses.update_license(socket.assigns.license, license_params) do
      {:ok, _license} ->
        {:noreply,
         socket
         |> put_flash(:info, "License updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_license(socket, :new, license_params) do
    case Licenses.create_license(license_params) do
      {:ok, _license} ->
        {:noreply,
         socket
         |> put_flash(:info, "License created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
