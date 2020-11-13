defmodule Corea.Initiatives do
  @moduledoc """
  The Initiatives context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Initiatives.Initiative

  @doc """
  Returns the list of initiatives.

  ## Examples

      iex> list_initiatives()
      [%Initiative{}, ...]

  """
  def list_initiatives do
    Repo.all(Initiative)
  end

  @doc """
  Gets a single initiative.

  Raises `Ecto.NoResultsError` if the Initiative does not exist.

  ## Examples

      iex> get_initiative!(123)
      %Initiative{}

      iex> get_initiative!(456)
      ** (Ecto.NoResultsError)

  """
  def get_initiative!(id), do: Repo.get!(Initiative, id)

  @doc """
  Creates a initiative.

  ## Examples

      iex> create_initiative(%{field: value})
      {:ok, %Initiative{}}

      iex> create_initiative(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_initiative(attrs \\ %{}) do
    %Initiative{}
    |> Initiative.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a initiative.

  ## Examples

      iex> update_initiative(initiative, %{field: new_value})
      {:ok, %Initiative{}}

      iex> update_initiative(initiative, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_initiative(%Initiative{} = initiative, attrs) do
    initiative
    |> Initiative.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a initiative.

  ## Examples

      iex> delete_initiative(initiative)
      {:ok, %Initiative{}}

      iex> delete_initiative(initiative)
      {:error, %Ecto.Changeset{}}

  """
  def delete_initiative(%Initiative{} = initiative) do
    Repo.delete(initiative)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking initiative changes.

  ## Examples

      iex> change_initiative(initiative)
      %Ecto.Changeset{data: %Initiative{}}

  """
  def change_initiative(%Initiative{} = initiative, attrs \\ %{}) do
    Initiative.changeset(initiative, attrs)
  end
end
