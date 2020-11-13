defmodule Corea.Openhashes do
  @moduledoc """
  The Openhashes context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Openhashes.Openhash

  @doc """
  Returns the list of openhashes.

  ## Examples

      iex> list_openhashes()
      [%Openhash{}, ...]

  """
  def list_openhashes do
    Repo.all(Openhash)
  end

  @doc """
  Gets a single openhash.

  Raises `Ecto.NoResultsError` if the Openhash does not exist.

  ## Examples

      iex> get_openhash!(123)
      %Openhash{}

      iex> get_openhash!(456)
      ** (Ecto.NoResultsError)

  """
  def get_openhash!(id), do: Repo.get!(Openhash, id)

  @doc """
  Creates a openhash.

  ## Examples

      iex> create_openhash(%{field: value})
      {:ok, %Openhash{}}

      iex> create_openhash(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_openhash(attrs \\ %{}) do
    %Openhash{}
    |> Openhash.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a openhash.

  ## Examples

      iex> update_openhash(openhash, %{field: new_value})
      {:ok, %Openhash{}}

      iex> update_openhash(openhash, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_openhash(%Openhash{} = openhash, attrs) do
    openhash
    |> Openhash.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a openhash.

  ## Examples

      iex> delete_openhash(openhash)
      {:ok, %Openhash{}}

      iex> delete_openhash(openhash)
      {:error, %Ecto.Changeset{}}

  """
  def delete_openhash(%Openhash{} = openhash) do
    Repo.delete(openhash)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking openhash changes.

  ## Examples

      iex> change_openhash(openhash)
      %Ecto.Changeset{data: %Openhash{}}

  """
  def change_openhash(%Openhash{} = openhash, attrs \\ %{}) do
    Openhash.changeset(openhash, attrs)
  end
end
