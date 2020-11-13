defmodule Corea.GPCCodes do
  @moduledoc """
  The GPCCodes context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GPCCodes.GPCCode

  @doc """
  Returns the list of gpc_codes.

  ## Examples

      iex> list_gpc_codes()
      [%GPCCode{}, ...]

  """
  def list_gpc_codes do
    Repo.all(GPCCode)
  end

  @doc """
  Gets a single gpc_code.

  Raises `Ecto.NoResultsError` if the Gpc code does not exist.

  ## Examples

      iex> get_gpc_code!(123)
      %GPCCode{}

      iex> get_gpc_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gpc_code!(id), do: Repo.get!(GPCCode, id)

  @doc """
  Creates a gpc_code.

  ## Examples

      iex> create_gpc_code(%{field: value})
      {:ok, %GPCCode{}}

      iex> create_gpc_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gpc_code(attrs \\ %{}) do
    %GPCCode{}
    |> GPCCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gpc_code.

  ## Examples

      iex> update_gpc_code(gpc_code, %{field: new_value})
      {:ok, %GPCCode{}}

      iex> update_gpc_code(gpc_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gpc_code(%GPCCode{} = gpc_code, attrs) do
    gpc_code
    |> GPCCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gpc_code.

  ## Examples

      iex> delete_gpc_code(gpc_code)
      {:ok, %GPCCode{}}

      iex> delete_gpc_code(gpc_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gpc_code(%GPCCode{} = gpc_code) do
    Repo.delete(gpc_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gpc_code changes.

  ## Examples

      iex> change_gpc_code(gpc_code)
      %Ecto.Changeset{data: %GPCCode{}}

  """
  def change_gpc_code(%GPCCode{} = gpc_code, attrs \\ %{}) do
    GPCCode.changeset(gpc_code, attrs)
  end
end
