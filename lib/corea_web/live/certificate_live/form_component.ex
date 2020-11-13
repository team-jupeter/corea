defmodule CoreaWeb.CertificateLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.Certificates

  @impl true
  def update(%{certificate: certificate} = assigns, socket) do
    changeset = Certificates.change_certificate(certificate)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"certificate" => certificate_params}, socket) do
    changeset =
      socket.assigns.certificate
      |> Certificates.change_certificate(certificate_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"certificate" => certificate_params}, socket) do
    save_certificate(socket, socket.assigns.action, certificate_params)
  end

  defp save_certificate(socket, :edit, certificate_params) do
    case Certificates.update_certificate(socket.assigns.certificate, certificate_params) do
      {:ok, _certificate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Certificate updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_certificate(socket, :new, certificate_params) do
    case Certificates.create_certificate(certificate_params) do
      {:ok, _certificate} ->
        {:noreply,
         socket
         |> put_flash(:info, "Certificate created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
