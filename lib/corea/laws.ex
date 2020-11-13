defmodule Corea.Laws do
  @moduledoc """
  The Laws context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Laws.Law

  @doc """
  Returns the list of laws.

  ## Examples

      iex> list_laws()
      [%Law{}, ...]

  """
  def list_laws do
    Repo.all(Law)
  end

  @doc """
  Gets a single law.

  Raises `Ecto.NoResultsError` if the Law does not exist.

  ## Examples

      iex> get_law!(123)
      %Law{}

      iex> get_law!(456)
      ** (Ecto.NoResultsError)

  """
  def get_law!(id), do: Repo.get!(Law, id)

  @doc """
  Creates a law.

  ## Examples

      iex> create_law(%{field: value})
      {:ok, %Law{}}

      iex> create_law(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_law(attrs \\ %{}) do
    %Law{}
    |> Law.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a law.

  ## Examples

      iex> update_law(law, %{field: new_value})
      {:ok, %Law{}}

      iex> update_law(law, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_law(%Law{} = law, attrs) do
    law
    |> Law.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a law.

  ## Examples

      iex> delete_law(law)
      {:ok, %Law{}}

      iex> delete_law(law)
      {:error, %Ecto.Changeset{}}

  """
  def delete_law(%Law{} = law) do
    Repo.delete(law)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking law changes.

  ## Examples

      iex> change_law(law)
      %Ecto.Changeset{data: %Law{}}

  """
  def change_law(%Law{} = law, attrs \\ %{}) do
    Law.changeset(law, attrs)
  end
end
