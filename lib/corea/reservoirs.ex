defmodule Corea.Reservoirs do
  @moduledoc """
  The Reservoirs context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Reservoirs.Reservoir

  @doc """
  Returns the list of reservoirs.

  ## Examples

      iex> list_reservoirs()
      [%Reservoir{}, ...]

  """
  def list_reservoirs do
    Repo.all(Reservoir)
  end

  @doc """
  Gets a single reservoir.

  Raises `Ecto.NoResultsError` if the Reservoir does not exist.

  ## Examples

      iex> get_reservoir!(123)
      %Reservoir{}

      iex> get_reservoir!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reservoir!(id), do: Repo.get!(Reservoir, id)

  @doc """
  Creates a reservoir.

  ## Examples

      iex> create_reservoir(%{field: value})
      {:ok, %Reservoir{}}

      iex> create_reservoir(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reservoir(attrs \\ %{}) do
    %Reservoir{}
    |> Reservoir.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reservoir.

  ## Examples

      iex> update_reservoir(reservoir, %{field: new_value})
      {:ok, %Reservoir{}}

      iex> update_reservoir(reservoir, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reservoir(%Reservoir{} = reservoir, attrs) do
    reservoir
    |> Reservoir.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reservoir.

  ## Examples

      iex> delete_reservoir(reservoir)
      {:ok, %Reservoir{}}

      iex> delete_reservoir(reservoir)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reservoir(%Reservoir{} = reservoir) do
    Repo.delete(reservoir)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reservoir changes.

  ## Examples

      iex> change_reservoir(reservoir)
      %Ecto.Changeset{data: %Reservoir{}}

  """
  def change_reservoir(%Reservoir{} = reservoir, attrs \\ %{}) do
    Reservoir.changeset(reservoir, attrs)
  end
end
