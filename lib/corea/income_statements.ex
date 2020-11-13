defmodule Corea.IncomeStatements do
  @moduledoc """
  The IncomeStatements context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.IncomeStatements.IncomeStatement

  @doc """
  Returns the list of income_statements.

  ## Examples

      iex> list_income_statements()
      [%IncomeStatement{}, ...]

  """
  def list_income_statements do
    Repo.all(IncomeStatement)
  end

  @doc """
  Gets a single income_statement.

  Raises `Ecto.NoResultsError` if the Income statement does not exist.

  ## Examples

      iex> get_income_statement!(123)
      %IncomeStatement{}

      iex> get_income_statement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_income_statement!(id), do: Repo.get!(IncomeStatement, id)

  @doc """
  Creates a income_statement.

  ## Examples

      iex> create_income_statement(%{field: value})
      {:ok, %IncomeStatement{}}

      iex> create_income_statement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_income_statement(attrs \\ %{}) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a income_statement.

  ## Examples

      iex> update_income_statement(income_statement, %{field: new_value})
      {:ok, %IncomeStatement{}}

      iex> update_income_statement(income_statement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_income_statement(%IncomeStatement{} = income_statement, attrs) do
    income_statement
    |> IncomeStatement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a income_statement.

  ## Examples

      iex> delete_income_statement(income_statement)
      {:ok, %IncomeStatement{}}

      iex> delete_income_statement(income_statement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_income_statement(%IncomeStatement{} = income_statement) do
    Repo.delete(income_statement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking income_statement changes.

  ## Examples

      iex> change_income_statement(income_statement)
      %Ecto.Changeset{data: %IncomeStatement{}}

  """
  def change_income_statement(%IncomeStatement{} = income_statement, attrs \\ %{}) do
    IncomeStatement.changeset(income_statement, attrs)
  end
end
