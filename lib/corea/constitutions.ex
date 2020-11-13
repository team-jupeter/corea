defmodule Corea.Constitutions do
  @moduledoc """
  The Constitutions context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Constitutions.Constitution

  @doc """
  Returns the list of constitutions.

  ## Examples

      iex> list_constitutions()
      [%Constitution{}, ...]

  """
  def list_constitutions do
    Repo.all(Constitution)
  end

  @doc """
  Gets a single constitution.

  Raises `Ecto.NoResultsError` if the Constitution does not exist.

  ## Examples

      iex> get_constitution!(123)
      %Constitution{}

      iex> get_constitution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_constitution!(id), do: Repo.get!(Constitution, id)

  @doc """
  Creates a constitution.

  ## Examples

      iex> create_constitution(%{field: value})
      {:ok, %Constitution{}}

      iex> create_constitution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_constitution(attrs \\ %{}) do
    %Constitution{}
    |> Constitution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a constitution.

  ## Examples

      iex> update_constitution(constitution, %{field: new_value})
      {:ok, %Constitution{}}

      iex> update_constitution(constitution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_constitution(%Constitution{} = constitution, attrs) do
    constitution
    |> Constitution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a constitution.

  ## Examples

      iex> delete_constitution(constitution)
      {:ok, %Constitution{}}

      iex> delete_constitution(constitution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_constitution(%Constitution{} = constitution) do
    Repo.delete(constitution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking constitution changes.

  ## Examples

      iex> change_constitution(constitution)
      %Ecto.Changeset{data: %Constitution{}}

  """
  def change_constitution(%Constitution{} = constitution, attrs \\ %{}) do
    Constitution.changeset(constitution, attrs)
  end
end
