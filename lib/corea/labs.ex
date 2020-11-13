defmodule Corea.Labs do
  @moduledoc """
  The Labs context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Labs.Lab

  @doc """
  Returns the list of labs.

  ## Examples

      iex> list_labs()
      [%Lab{}, ...]

  """
  def list_labs do
    Repo.all(Lab)
  end

  @doc """
  Gets a single lab.

  Raises `Ecto.NoResultsError` if the Lab does not exist.

  ## Examples

      iex> get_lab!(123)
      %Lab{}

      iex> get_lab!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lab!(id), do: Repo.get!(Lab, id)

  @doc """
  Creates a lab.

  ## Examples

      iex> create_lab(%{field: value})
      {:ok, %Lab{}}

      iex> create_lab(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lab(attrs \\ %{}) do
    %Lab{}
    |> Lab.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lab.

  ## Examples

      iex> update_lab(lab, %{field: new_value})
      {:ok, %Lab{}}

      iex> update_lab(lab, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lab(%Lab{} = lab, attrs) do
    lab
    |> Lab.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lab.

  ## Examples

      iex> delete_lab(lab)
      {:ok, %Lab{}}

      iex> delete_lab(lab)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lab(%Lab{} = lab) do
    Repo.delete(lab)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lab changes.

  ## Examples

      iex> change_lab(lab)
      %Ecto.Changeset{data: %Lab{}}

  """
  def change_lab(%Lab{} = lab, attrs \\ %{}) do
    Lab.changeset(lab, attrs)
  end
end
