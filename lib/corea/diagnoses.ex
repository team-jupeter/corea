defmodule Corea.Diagnoses do
  @moduledoc """
  The Diagnoses context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Diagnoses.Diagnosis

  @doc """
  Returns the list of diagnoses.

  ## Examples

      iex> list_diagnoses()
      [%Diagnosis{}, ...]

  """
  def list_diagnoses do
    Repo.all(Diagnosis)
  end

  @doc """
  Gets a single diagnosis.

  Raises `Ecto.NoResultsError` if the Diagnosis does not exist.

  ## Examples

      iex> get_diagnosis!(123)
      %Diagnosis{}

      iex> get_diagnosis!(456)
      ** (Ecto.NoResultsError)

  """
  def get_diagnosis!(id), do: Repo.get!(Diagnosis, id)

  @doc """
  Creates a diagnosis.

  ## Examples

      iex> create_diagnosis(%{field: value})
      {:ok, %Diagnosis{}}

      iex> create_diagnosis(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_diagnosis(attrs \\ %{}) do
    %Diagnosis{}
    |> Diagnosis.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a diagnosis.

  ## Examples

      iex> update_diagnosis(diagnosis, %{field: new_value})
      {:ok, %Diagnosis{}}

      iex> update_diagnosis(diagnosis, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_diagnosis(%Diagnosis{} = diagnosis, attrs) do
    diagnosis
    |> Diagnosis.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a diagnosis.

  ## Examples

      iex> delete_diagnosis(diagnosis)
      {:ok, %Diagnosis{}}

      iex> delete_diagnosis(diagnosis)
      {:error, %Ecto.Changeset{}}

  """
  def delete_diagnosis(%Diagnosis{} = diagnosis) do
    Repo.delete(diagnosis)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking diagnosis changes.

  ## Examples

      iex> change_diagnosis(diagnosis)
      %Ecto.Changeset{data: %Diagnosis{}}

  """
  def change_diagnosis(%Diagnosis{} = diagnosis, attrs \\ %{}) do
    Diagnosis.changeset(diagnosis, attrs)
  end
end
