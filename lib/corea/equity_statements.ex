defmodule Corea.EquityStatements do
  @moduledoc """
  The EquityStatements context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.EquityStatements.EquityStatement

  @doc """
  Returns the list of equity_statements.

  ## Examples

      iex> list_equity_statements()
      [%EquityStatement{}, ...]

  """
  def list_equity_statements do
    Repo.all(EquityStatement)
  end

  @doc """
  Gets a single equity_statement.

  Raises `Ecto.NoResultsError` if the Equity statement does not exist.

  ## Examples

      iex> get_equity_statement!(123)
      %EquityStatement{}

      iex> get_equity_statement!(456)
      ** (Ecto.NoResultsError)

  """
  def get_equity_statement!(id), do: Repo.get!(EquityStatement, id)

  @doc """
  Creates a equity_statement.

  ## Examples

      iex> create_equity_statement(%{field: value})
      {:ok, %EquityStatement{}}

      iex> create_equity_statement(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_equity_statement(attrs \\ %{}) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a equity_statement.

  ## Examples

      iex> update_equity_statement(equity_statement, %{field: new_value})
      {:ok, %EquityStatement{}}

      iex> update_equity_statement(equity_statement, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_equity_statement(%EquityStatement{} = equity_statement, attrs) do
    equity_statement
    |> EquityStatement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a equity_statement.

  ## Examples

      iex> delete_equity_statement(equity_statement)
      {:ok, %EquityStatement{}}

      iex> delete_equity_statement(equity_statement)
      {:error, %Ecto.Changeset{}}

  """
  def delete_equity_statement(%EquityStatement{} = equity_statement) do
    Repo.delete(equity_statement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking equity_statement changes.

  ## Examples

      iex> change_equity_statement(equity_statement)
      %Ecto.Changeset{data: %EquityStatement{}}

  """
  def change_equity_statement(%EquityStatement{} = equity_statement, attrs \\ %{}) do
    EquityStatement.changeset(equity_statement, attrs)
  end
end
