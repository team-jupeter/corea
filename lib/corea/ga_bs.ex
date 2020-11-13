defmodule Corea.GABs do
  @moduledoc """
  The GABs context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GABs.GAB

  @doc """
  Returns the list of gabs.

  ## Examples

      iex> list_gabs()
      [%GAB{}, ...]

  """
  def list_gabs do
    Repo.all(GAB)
  end

  @doc """
  Gets a single gab.

  Raises `Ecto.NoResultsError` if the Gab does not exist.

  ## Examples

      iex> get_gab!(123)
      %GAB{}

      iex> get_gab!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gab!(id), do: Repo.get!(GAB, id)

  @doc """
  Creates a gab.

  ## Examples

      iex> create_gab(%{field: value})
      {:ok, %GAB{}}

      iex> create_gab(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gab(attrs \\ %{}) do
    %GAB{}
    |> GAB.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gab.

  ## Examples

      iex> update_gab(gab, %{field: new_value})
      {:ok, %GAB{}}

      iex> update_gab(gab, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gab(%GAB{} = gab, attrs) do
    gab
    |> GAB.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gab.

  ## Examples

      iex> delete_gab(gab)
      {:ok, %GAB{}}

      iex> delete_gab(gab)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gab(%GAB{} = gab) do
    Repo.delete(gab)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gab changes.

  ## Examples

      iex> change_gab(gab)
      %Ecto.Changeset{data: %GAB{}}

  """
  def change_gab(%GAB{} = gab, attrs \\ %{}) do
    GAB.changeset(gab, attrs)
  end
end
