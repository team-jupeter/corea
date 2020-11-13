defmodule Corea.T3s do
  @moduledoc """
  The T3s context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.T3s.T3

  @doc """
  Returns the list of t3s.

  ## Examples

      iex> list_t3s()
      [%T3{}, ...]

  """
  def list_t3s do
    Repo.all(T3)
  end

  @doc """
  Gets a single t3.

  Raises `Ecto.NoResultsError` if the T3 does not exist.

  ## Examples

      iex> get_t3!(123)
      %T3{}

      iex> get_t3!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t3!(id), do: Repo.get!(T3, id)

  @doc """
  Creates a t3.

  ## Examples

      iex> create_t3(%{field: value})
      {:ok, %T3{}}

      iex> create_t3(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t3(attrs \\ %{}) do
    %T3{}
    |> T3.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t3.

  ## Examples

      iex> update_t3(t3, %{field: new_value})
      {:ok, %T3{}}

      iex> update_t3(t3, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t3(%T3{} = t3, attrs) do
    t3
    |> T3.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t3.

  ## Examples

      iex> delete_t3(t3)
      {:ok, %T3{}}

      iex> delete_t3(t3)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t3(%T3{} = t3) do
    Repo.delete(t3)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t3 changes.

  ## Examples

      iex> change_t3(t3)
      %Ecto.Changeset{data: %T3{}}

  """
  def change_t3(%T3{} = t3, attrs \\ %{}) do
    T3.changeset(t3, attrs)
  end
end
