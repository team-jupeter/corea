defmodule Corea.Polices do
  @moduledoc """
  The Polices context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Polices.Police

  @doc """
  Returns the list of polices.

  ## Examples

      iex> list_polices()
      [%Police{}, ...]

  """
  def list_polices do
    Repo.all(Police)
  end

  @doc """
  Gets a single police.

  Raises `Ecto.NoResultsError` if the Police does not exist.

  ## Examples

      iex> get_police!(123)
      %Police{}

      iex> get_police!(456)
      ** (Ecto.NoResultsError)

  """
  def get_police!(id), do: Repo.get!(Police, id)

  @doc """
  Creates a police.

  ## Examples

      iex> create_police(%{field: value})
      {:ok, %Police{}}

      iex> create_police(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_police(attrs \\ %{}) do
    %Police{}
    |> Police.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a police.

  ## Examples

      iex> update_police(police, %{field: new_value})
      {:ok, %Police{}}

      iex> update_police(police, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_police(%Police{} = police, attrs) do
    police
    |> Police.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a police.

  ## Examples

      iex> delete_police(police)
      {:ok, %Police{}}

      iex> delete_police(police)
      {:error, %Ecto.Changeset{}}

  """
  def delete_police(%Police{} = police) do
    Repo.delete(police)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking police changes.

  ## Examples

      iex> change_police(police)
      %Ecto.Changeset{data: %Police{}}

  """
  def change_police(%Police{} = police, attrs \\ %{}) do
    Police.changeset(police, attrs)
  end
end
