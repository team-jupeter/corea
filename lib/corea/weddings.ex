defmodule Corea.Weddings do
  @moduledoc """
  The Weddings context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Weddings.Wedding

  @doc """
  Returns the list of weddings.

  ## Examples

      iex> list_weddings()
      [%Wedding{}, ...]

  """
  def list_weddings do
    Repo.all(Wedding)
  end

  @doc """
  Gets a single wedding.

  Raises `Ecto.NoResultsError` if the Wedding does not exist.

  ## Examples

      iex> get_wedding!(123)
      %Wedding{}

      iex> get_wedding!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wedding!(id), do: Repo.get!(Wedding, id)

  @doc """
  Creates a wedding.

  ## Examples

      iex> create_wedding(%{field: value})
      {:ok, %Wedding{}}

      iex> create_wedding(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_wedding(attrs \\ %{}) do
    %Wedding{}
    |> Wedding.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wedding.

  ## Examples

      iex> update_wedding(wedding, %{field: new_value})
      {:ok, %Wedding{}}

      iex> update_wedding(wedding, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wedding(%Wedding{} = wedding, attrs) do
    wedding
    |> Wedding.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a wedding.

  ## Examples

      iex> delete_wedding(wedding)
      {:ok, %Wedding{}}

      iex> delete_wedding(wedding)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wedding(%Wedding{} = wedding) do
    Repo.delete(wedding)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wedding changes.

  ## Examples

      iex> change_wedding(wedding)
      %Ecto.Changeset{data: %Wedding{}}

  """
  def change_wedding(%Wedding{} = wedding, attrs \\ %{}) do
    Wedding.changeset(wedding, attrs)
  end
end
