defmodule Corea.Applicants do
  @moduledoc """
  The Applicants context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Applicants.Applicant

  @doc """
  Returns the list of applicants.

  ## Examples

      iex> list_applicants()
      [%Applicant{}, ...]

  """
  def list_applicants do
    Repo.all(Applicant)
  end

  @doc """
  Gets a single applicant.

  Raises `Ecto.NoResultsError` if the Applicant does not exist.

  ## Examples

      iex> get_applicant!(123)
      %Applicant{}

      iex> get_applicant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_applicant!(id), do: Repo.get!(Applicant, id)

  @doc """
  Creates a applicant.

  ## Examples

      iex> create_applicant(%{field: value})
      {:ok, %Applicant{}}

      iex> create_applicant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_applicant(attrs \\ %{}) do
    %Applicant{}
    |> Applicant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a applicant.

  ## Examples

      iex> update_applicant(applicant, %{field: new_value})
      {:ok, %Applicant{}}

      iex> update_applicant(applicant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_applicant(%Applicant{} = applicant, attrs) do
    applicant
    |> Applicant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a applicant.

  ## Examples

      iex> delete_applicant(applicant)
      {:ok, %Applicant{}}

      iex> delete_applicant(applicant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_applicant(%Applicant{} = applicant) do
    Repo.delete(applicant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking applicant changes.

  ## Examples

      iex> change_applicant(applicant)
      %Ecto.Changeset{data: %Applicant{}}

  """
  def change_applicant(%Applicant{} = applicant, attrs \\ %{}) do
    Applicant.changeset(applicant, attrs)
  end
end
