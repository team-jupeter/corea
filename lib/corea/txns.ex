defmodule Corea.Txns do
  @moduledoc """
  The Txns context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Txns.Txn

  @doc """
  Returns the list of txns.

  ## Examples

      iex> list_txns()
      [%Txn{}, ...]

  """
  def list_txns do
    Repo.all(Txn)
  end

  @doc """
  Gets a single txn.

  Raises `Ecto.NoResultsError` if the Txn does not exist.

  ## Examples

      iex> get_txn!(123)
      %Txn{}

      iex> get_txn!(456)
      ** (Ecto.NoResultsError)

  """
  def get_txn!(id), do: Repo.get!(Txn, id)

  @doc """
  Creates a txn.

  ## Examples

      iex> create_txn(%{field: value})
      {:ok, %Txn{}}

      iex> create_txn(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_txn(attrs \\ %{}) do
    %Txn{}
    |> Txn.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a txn.

  ## Examples

      iex> update_txn(txn, %{field: new_value})
      {:ok, %Txn{}}

      iex> update_txn(txn, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_txn(%Txn{} = txn, attrs) do
    txn
    |> Txn.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a txn.

  ## Examples

      iex> delete_txn(txn)
      {:ok, %Txn{}}

      iex> delete_txn(txn)
      {:error, %Ecto.Changeset{}}

  """
  def delete_txn(%Txn{} = txn) do
    Repo.delete(txn)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking txn changes.

  ## Examples

      iex> change_txn(txn)
      %Ecto.Changeset{data: %Txn{}}

  """
  def change_txn(%Txn{} = txn, attrs \\ %{}) do
    Txn.changeset(txn, attrs)
  end
end
