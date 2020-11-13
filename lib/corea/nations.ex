defmodule Corea.Nations do
  @moduledoc """
  The Nations context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Nations.Nation

  @doc """
  Returns the list of nations.

  ## Examples

      iex> list_nations()
      [%Nation{}, ...]

  """
  def list_nations do
    Repo.all(Nation)
  end

  @doc """
  Gets a single nation.

  Raises `Ecto.NoResultsError` if the Nation does not exist.

  ## Examples

      iex> get_nation!(123)
      %Nation{}

      iex> get_nation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nation!(id), do: Repo.get!(Nation, id)

  @doc """
  Creates a nation.

  ## Examples

      iex> create_nation(%{field: value})
      {:ok, %Nation{}}

      iex> create_nation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nation(attrs \\ %{}) do
    %Nation{}
    |> Nation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nation.

  ## Examples

      iex> update_nation(nation, %{field: new_value})
      {:ok, %Nation{}}

      iex> update_nation(nation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nation(%Nation{} = nation, attrs) do
    nation
    |> Nation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nation.

  ## Examples

      iex> delete_nation(nation)
      {:ok, %Nation{}}

      iex> delete_nation(nation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nation(%Nation{} = nation) do
    Repo.delete(nation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nation changes.

  ## Examples

      iex> change_nation(nation)
      %Ecto.Changeset{data: %Nation{}}

  """
  def change_nation(%Nation{} = nation, attrs \\ %{}) do
    Nation.changeset(nation, attrs)
  end
end
