defmodule Corea.T1s do
  @moduledoc """
  The T1s context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.T1s.T1

  @doc """
  Returns the list of t1s.

  ## Examples

      iex> list_t1s()
      [%T1{}, ...]

  """
  def list_t1s do
    Repo.all(T1)
  end

  @doc """
  Gets a single t1.

  Raises `Ecto.NoResultsError` if the T1 does not exist.

  ## Examples

      iex> get_t1!(123)
      %T1{}

      iex> get_t1!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t1!(id), do: Repo.get!(T1, id)

  @doc """
  Creates a t1.

  ## Examples

      iex> create_t1(%{field: value})
      {:ok, %T1{}}

      iex> create_t1(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t1(attrs \\ %{}) do
    %T1{}
    |> T1.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t1.

  ## Examples

      iex> update_t1(t1, %{field: new_value})
      {:ok, %T1{}}

      iex> update_t1(t1, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t1(%T1{} = t1, attrs) do
    t1
    |> T1.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t1.

  ## Examples

      iex> delete_t1(t1)
      {:ok, %T1{}}

      iex> delete_t1(t1)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t1(%T1{} = t1) do
    Repo.delete(t1)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t1 changes.

  ## Examples

      iex> change_t1(t1)
      %Ecto.Changeset{data: %T1{}}

  """
  def change_t1(%T1{} = t1, attrs \\ %{}) do
    T1.changeset(t1, attrs)
  end
end
