defmodule Corea.Gopangs do
  @moduledoc """
  The Gopangs context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Gopangs.Gopang

  @doc """
  Returns the list of gopangs.

  ## Examples

      iex> list_gopangs()
      [%Gopang{}, ...]

  """
  def list_gopangs do
    Repo.all(Gopang)
  end

  @doc """
  Gets a single gopang.

  Raises `Ecto.NoResultsError` if the Gopang does not exist.

  ## Examples

      iex> get_gopang!(123)
      %Gopang{}

      iex> get_gopang!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gopang!(id), do: Repo.get!(Gopang, id)

  @doc """
  Creates a gopang.

  ## Examples

      iex> create_gopang(%{field: value})
      {:ok, %Gopang{}}

      iex> create_gopang(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gopang(attrs \\ %{}) do
    %Gopang{}
    |> Gopang.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gopang.

  ## Examples

      iex> update_gopang(gopang, %{field: new_value})
      {:ok, %Gopang{}}

      iex> update_gopang(gopang, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gopang(%Gopang{} = gopang, attrs) do
    gopang
    |> Gopang.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gopang.

  ## Examples

      iex> delete_gopang(gopang)
      {:ok, %Gopang{}}

      iex> delete_gopang(gopang)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gopang(%Gopang{} = gopang) do
    Repo.delete(gopang)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gopang changes.

  ## Examples

      iex> change_gopang(gopang)
      %Ecto.Changeset{data: %Gopang{}}

  """
  def change_gopang(%Gopang{} = gopang, attrs \\ %{}) do
    Gopang.changeset(gopang, attrs)
  end
end
