defmodule Corea.HealthReports do
  @moduledoc """
  The HealthReports context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.HealthReports.HealthReport

  @doc """
  Returns the list of health_reports.

  ## Examples

      iex> list_health_reports()
      [%HealthReport{}, ...]

  """
  def list_health_reports do
    Repo.all(HealthReport)
  end

  @doc """
  Gets a single health_report.

  Raises `Ecto.NoResultsError` if the Health report does not exist.

  ## Examples

      iex> get_health_report!(123)
      %HealthReport{}

      iex> get_health_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_health_report!(id), do: Repo.get!(HealthReport, id)

  @doc """
  Creates a health_report.

  ## Examples

      iex> create_health_report(%{field: value})
      {:ok, %HealthReport{}}

      iex> create_health_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_health_report(attrs \\ %{}) do
    %HealthReport{}
    |> HealthReport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a health_report.

  ## Examples

      iex> update_health_report(health_report, %{field: new_value})
      {:ok, %HealthReport{}}

      iex> update_health_report(health_report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_health_report(%HealthReport{} = health_report, attrs) do
    health_report
    |> HealthReport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a health_report.

  ## Examples

      iex> delete_health_report(health_report)
      {:ok, %HealthReport{}}

      iex> delete_health_report(health_report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_health_report(%HealthReport{} = health_report) do
    Repo.delete(health_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking health_report changes.

  ## Examples

      iex> change_health_report(health_report)
      %Ecto.Changeset{data: %HealthReport{}}

  """
  def change_health_report(%HealthReport{} = health_report, attrs \\ %{}) do
    HealthReport.changeset(health_report, attrs)
  end
end
