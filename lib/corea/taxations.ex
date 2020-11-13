defmodule Corea.Taxations do
  @moduledoc """
  The Taxations context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Taxations.Taxation

  @doc """
  Returns the list of taxations.

  ## Examples

      iex> list_taxations()
      [%Taxation{}, ...]

  """
  def list_taxations do
    Repo.all(Taxation)
  end

  @doc """
  Gets a single taxation.

  Raises `Ecto.NoResultsError` if the Taxation does not exist.

  ## Examples

      iex> get_taxation!(123)
      %Taxation{}

      iex> get_taxation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_taxation!(id), do: Repo.get!(Taxation, id)

  @doc """
  Creates a taxation.

  ## Examples

      iex> create_taxation(%{field: value})
      {:ok, %Taxation{}}

      iex> create_taxation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_taxation(attrs \\ %{}) do
    %Taxation{}
    |> Taxation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a taxation.

  ## Examples

      iex> update_taxation(taxation, %{field: new_value})
      {:ok, %Taxation{}}

      iex> update_taxation(taxation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_taxation(%Taxation{} = taxation, attrs) do
    taxation
    |> Taxation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a taxation.

  ## Examples

      iex> delete_taxation(taxation)
      {:ok, %Taxation{}}

      iex> delete_taxation(taxation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_taxation(%Taxation{} = taxation) do
    Repo.delete(taxation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking taxation changes.

  ## Examples

      iex> change_taxation(taxation)
      %Ecto.Changeset{data: %Taxation{}}

  """
  def change_taxation(%Taxation{} = taxation, attrs \\ %{}) do
    Taxation.changeset(taxation, attrs)
  end
end
