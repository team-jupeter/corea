defmodule Corea.T5s do
  @moduledoc """
  The T5s context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.T5s.T5

  @doc """
  Returns the list of t5s.

  ## Examples

      iex> list_t5s()
      [%T5{}, ...]

  """
  def list_t5s do
    Repo.all(T5)
  end

  @doc """
  Gets a single t5.

  Raises `Ecto.NoResultsError` if the T5 does not exist.

  ## Examples

      iex> get_t5!(123)
      %T5{}

      iex> get_t5!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t5!(id), do: Repo.get!(T5, id)

  @doc """
  Creates a t5.

  ## Examples

      iex> create_t5(%{field: value})
      {:ok, %T5{}}

      iex> create_t5(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t5(attrs \\ %{}) do
    %T5{}
    |> T5.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t5.

  ## Examples

      iex> update_t5(t5, %{field: new_value})
      {:ok, %T5{}}

      iex> update_t5(t5, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t5(%T5{} = t5, attrs) do
    t5
    |> T5.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t5.

  ## Examples

      iex> delete_t5(t5)
      {:ok, %T5{}}

      iex> delete_t5(t5)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t5(%T5{} = t5) do
    Repo.delete(t5)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t5 changes.

  ## Examples

      iex> change_t5(t5)
      %Ecto.Changeset{data: %T5{}}

  """
  def change_t5(%T5{} = t5, attrs \\ %{}) do
    T5.changeset(t5, attrs)
  end
end
