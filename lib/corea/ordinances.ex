defmodule Corea.Ordinances do
  @moduledoc """
  The Ordinances context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Ordinances.Ordinance

  @doc """
  Returns the list of ordinances.

  ## Examples

      iex> list_ordinances()
      [%Ordinance{}, ...]

  """
  def list_ordinances do
    Repo.all(Ordinance)
  end

  @doc """
  Gets a single ordinance.

  Raises `Ecto.NoResultsError` if the Ordinance does not exist.

  ## Examples

      iex> get_ordinance!(123)
      %Ordinance{}

      iex> get_ordinance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ordinance!(id), do: Repo.get!(Ordinance, id)

  @doc """
  Creates a ordinance.

  ## Examples

      iex> create_ordinance(%{field: value})
      {:ok, %Ordinance{}}

      iex> create_ordinance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ordinance(attrs \\ %{}) do
    %Ordinance{}
    |> Ordinance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ordinance.

  ## Examples

      iex> update_ordinance(ordinance, %{field: new_value})
      {:ok, %Ordinance{}}

      iex> update_ordinance(ordinance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ordinance(%Ordinance{} = ordinance, attrs) do
    ordinance
    |> Ordinance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ordinance.

  ## Examples

      iex> delete_ordinance(ordinance)
      {:ok, %Ordinance{}}

      iex> delete_ordinance(ordinance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ordinance(%Ordinance{} = ordinance) do
    Repo.delete(ordinance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ordinance changes.

  ## Examples

      iex> change_ordinance(ordinance)
      %Ecto.Changeset{data: %Ordinance{}}

  """
  def change_ordinance(%Ordinance{} = ordinance, attrs \\ %{}) do
    Ordinance.changeset(ordinance, attrs)
  end
end
