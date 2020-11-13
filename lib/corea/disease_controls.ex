defmodule Corea.DiseaseControls do
  @moduledoc """
  The DiseaseControls context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.DiseaseControls.DiseaseControl

  @doc """
  Returns the list of disease_controls.

  ## Examples

      iex> list_disease_controls()
      [%DiseaseControl{}, ...]

  """
  def list_disease_controls do
    Repo.all(DiseaseControl)
  end

  @doc """
  Gets a single disease_control.

  Raises `Ecto.NoResultsError` if the Disease control does not exist.

  ## Examples

      iex> get_disease_control!(123)
      %DiseaseControl{}

      iex> get_disease_control!(456)
      ** (Ecto.NoResultsError)

  """
  def get_disease_control!(id), do: Repo.get!(DiseaseControl, id)

  @doc """
  Creates a disease_control.

  ## Examples

      iex> create_disease_control(%{field: value})
      {:ok, %DiseaseControl{}}

      iex> create_disease_control(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_disease_control(attrs \\ %{}) do
    %DiseaseControl{}
    |> DiseaseControl.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a disease_control.

  ## Examples

      iex> update_disease_control(disease_control, %{field: new_value})
      {:ok, %DiseaseControl{}}

      iex> update_disease_control(disease_control, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_disease_control(%DiseaseControl{} = disease_control, attrs) do
    disease_control
    |> DiseaseControl.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a disease_control.

  ## Examples

      iex> delete_disease_control(disease_control)
      {:ok, %DiseaseControl{}}

      iex> delete_disease_control(disease_control)
      {:error, %Ecto.Changeset{}}

  """
  def delete_disease_control(%DiseaseControl{} = disease_control) do
    Repo.delete(disease_control)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking disease_control changes.

  ## Examples

      iex> change_disease_control(disease_control)
      %Ecto.Changeset{data: %DiseaseControl{}}

  """
  def change_disease_control(%DiseaseControl{} = disease_control, attrs \\ %{}) do
    DiseaseControl.changeset(disease_control, attrs)
  end
end
