defmodule Corea.Treatments do
  @moduledoc """
  The Treatments context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.Treatments.Treatment

  @doc """
  Returns the list of treatments.

  ## Examples

      iex> list_treatments()
      [%Treatment{}, ...]

  """
  def list_treatments do
    Repo.all(Treatment)
  end

  @doc """
  Gets a single treatment.

  Raises `Ecto.NoResultsError` if the Treatment does not exist.

  ## Examples

      iex> get_treatment!(123)
      %Treatment{}

      iex> get_treatment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_treatment!(id), do: Repo.get!(Treatment, id)

  @doc """
  Creates a treatment.

  ## Examples

      iex> create_treatment(%{field: value})
      {:ok, %Treatment{}}

      iex> create_treatment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_treatment(attrs \\ %{}) do
    %Treatment{}
    |> Treatment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a treatment.

  ## Examples

      iex> update_treatment(treatment, %{field: new_value})
      {:ok, %Treatment{}}

      iex> update_treatment(treatment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_treatment(%Treatment{} = treatment, attrs) do
    treatment
    |> Treatment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a treatment.

  ## Examples

      iex> delete_treatment(treatment)
      {:ok, %Treatment{}}

      iex> delete_treatment(treatment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_treatment(%Treatment{} = treatment) do
    Repo.delete(treatment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking treatment changes.

  ## Examples

      iex> change_treatment(treatment)
      %Ecto.Changeset{data: %Treatment{}}

  """
  def change_treatment(%Treatment{} = treatment, attrs \\ %{}) do
    Treatment.changeset(treatment, attrs)
  end
end
