defmodule Corea.FinancialReports do
  @moduledoc """
  The FinancialReports context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.FinancialReports.FinancialReport

  @doc """
  Returns the list of financial_reports.

  ## Examples

      iex> list_financial_reports()
      [%FinancialReport{}, ...]

  """
  def list_financial_reports do
    Repo.all(FinancialReport)
  end

  @doc """
  Gets a single financial_report.

  Raises `Ecto.NoResultsError` if the Financial report does not exist.

  ## Examples

      iex> get_financial_report!(123)
      %FinancialReport{}

      iex> get_financial_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_financial_report!(id), do: Repo.get!(FinancialReport, id)

  @doc """
  Creates a financial_report.

  ## Examples

      iex> create_financial_report(%{field: value})
      {:ok, %FinancialReport{}}

      iex> create_financial_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_financial_report(attrs \\ %{}) do
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a financial_report.

  ## Examples

      iex> update_financial_report(financial_report, %{field: new_value})
      {:ok, %FinancialReport{}}

      iex> update_financial_report(financial_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_financial_report(%FinancialReport{} = financial_report, attrs) do
    financial_report
    |> FinancialReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a financial_report.

  ## Examples

      iex> delete_financial_report(financial_report)
      {:ok, %FinancialReport{}}

      iex> delete_financial_report(financial_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_financial_report(%FinancialReport{} = financial_report) do
    Repo.delete(financial_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking financial_report changes.

  ## Examples

      iex> change_financial_report(financial_report)
      %Ecto.Changeset{data: %FinancialReport{}}

  """
  def change_financial_report(%FinancialReport{} = financial_report, attrs \\ %{}) do
    FinancialReport.changeset(financial_report, attrs)
  end
end
