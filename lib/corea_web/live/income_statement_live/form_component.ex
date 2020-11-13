defmodule CoreaWeb.IncomeStatementLive.FormComponent do
  use CoreaWeb, :live_component

  alias Corea.IncomeStatements

  @impl true
  def update(%{income_statement: income_statement} = assigns, socket) do
    changeset = IncomeStatements.change_income_statement(income_statement)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"income_statement" => income_statement_params}, socket) do
    changeset =
      socket.assigns.income_statement
      |> IncomeStatements.change_income_statement(income_statement_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"income_statement" => income_statement_params}, socket) do
    save_income_statement(socket, socket.assigns.action, income_statement_params)
  end

  defp save_income_statement(socket, :edit, income_statement_params) do
    case IncomeStatements.update_income_statement(socket.assigns.income_statement, income_statement_params) do
      {:ok, _income_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Income statement updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_income_statement(socket, :new, income_statement_params) do
    case IncomeStatements.create_income_statement(income_statement_params) do
      {:ok, _income_statement} ->
        {:noreply,
         socket
         |> put_flash(:info, "Income statement created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
