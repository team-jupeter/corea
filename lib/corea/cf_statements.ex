defmodule Corea.CFStatements do
  @moduledoc """
  The CFStatements context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.CFStatements.CFStatement

  @doc """
  Returns the list of cf_statements.

  ## Examples

      iex> list_cf_statements()
      [%CFStatement{}, ...]

  """
  def list_cf_statements do
    Repo.all(CFStatement)
  end

  @doc """
  Gets a single cf_statement.

  Raises `Ecto.NoResultsError` if the Cf statement does not exist.

  ## Examples

      iex> get_cf_statement!(123)
      %CFStatement{}

      iex> get_cf_statement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cf_statement!(id), do: Repo.get!(CFStatement, id)

  @doc """
  Creates a cf_statement.

  ## Examples

      iex> create_cf_statement(%{field: value})
      {:ok, %CFStatement{}}

      iex> create_cf_statement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cf_statement(attrs \\ %{}) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cf_statement.

  ## Examples

      iex> update_cf_statement(cf_statement, %{field: new_value})
      {:ok, %CFStatement{}}

      iex> update_cf_statement(cf_statement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cf_statement(%CFStatement{} = cf_statement, attrs) do
    cf_statement
    |> CFStatement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cf_statement.

  ## Examples

      iex> delete_cf_statement(cf_statement)
      {:ok, %CFStatement{}}

      iex> delete_cf_statement(cf_statement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cf_statement(%CFStatement{} = cf_statement) do
    Repo.delete(cf_statement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cf_statement changes.

  ## Examples

      iex> change_cf_statement(cf_statement)
      %Ecto.Changeset{data: %CFStatement{}}

  """
  def change_cf_statement(%CFStatement{} = cf_statement, attrs \\ %{}) do
    CFStatement.changeset(cf_statement, attrs)
  end
end
