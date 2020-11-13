defmodule Corea.T4s do
  @moduledoc """
  The T4s context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.T4s.T4

  @doc """
  Returns the list of t4s.

  ## Examples

      iex> list_t4s()
      [%T4{}, ...]

  """
  def list_t4s do
    Repo.all(T4)
  end

  @doc """
  Gets a single t4.

  Raises `Ecto.NoResultsError` if the T4 does not exist.

  ## Examples

      iex> get_t4!(123)
      %T4{}

      iex> get_t4!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t4!(id), do: Repo.get!(T4, id)

  @doc """
  Creates a t4.

  ## Examples

      iex> create_t4(%{field: value})
      {:ok, %T4{}}

      iex> create_t4(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t4(attrs \\ %{}) do
    %T4{}
    |> T4.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t4.

  ## Examples

      iex> update_t4(t4, %{field: new_value})
      {:ok, %T4{}}

      iex> update_t4(t4, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t4(%T4{} = t4, attrs) do
    t4
    |> T4.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t4.

  ## Examples

      iex> delete_t4(t4)
      {:ok, %T4{}}

      iex> delete_t4(t4)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t4(%T4{} = t4) do
    Repo.delete(t4)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t4 changes.

  ## Examples

      iex> change_t4(t4)
      %Ecto.Changeset{data: %T4{}}

  """
  def change_t4(%T4{} = t4, attrs \\ %{}) do
    T4.changeset(t4, attrs)
  end
end
