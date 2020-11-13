defmodule Corea.T2s do
  @moduledoc """
  The T2s context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.T2s.T2

  @doc """
  Returns the list of t2s.

  ## Examples

      iex> list_t2s()
      [%T2{}, ...]

  """
  def list_t2s do
    Repo.all(T2)
  end

  @doc """
  Gets a single t2.

  Raises `Ecto.NoResultsError` if the T2 does not exist.

  ## Examples

      iex> get_t2!(123)
      %T2{}

      iex> get_t2!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t2!(id), do: Repo.get!(T2, id)

  @doc """
  Creates a t2.

  ## Examples

      iex> create_t2(%{field: value})
      {:ok, %T2{}}

      iex> create_t2(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t2(attrs \\ %{}) do
    %T2{}
    |> T2.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t2.

  ## Examples

      iex> update_t2(t2, %{field: new_value})
      {:ok, %T2{}}

      iex> update_t2(t2, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t2(%T2{} = t2, attrs) do
    t2
    |> T2.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t2.

  ## Examples

      iex> delete_t2(t2)
      {:ok, %T2{}}

      iex> delete_t2(t2)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t2(%T2{} = t2) do
    Repo.delete(t2)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t2 changes.

  ## Examples

      iex> change_t2(t2)
      %Ecto.Changeset{data: %T2{}}

  """
  def change_t2(%T2{} = t2, attrs \\ %{}) do
    T2.changeset(t2, attrs)
  end
end
