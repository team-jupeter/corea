defmodule Corea.TaxRates do
  @moduledoc """
  The TaxRates context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.TaxRates.TaxRate

  @doc """
  Returns the list of tax_rates.

  ## Examples

      iex> list_tax_rates()
      [%TaxRate{}, ...]

  """
  def list_tax_rates do
    Repo.all(TaxRate)
  end

  @doc """
  Gets a single tax_rate.

  Raises `Ecto.NoResultsError` if the Tax rate does not exist.

  ## Examples

      iex> get_tax_rate!(123)
      %TaxRate{}

      iex> get_tax_rate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tax_rate!(id), do: Repo.get!(TaxRate, id)

  @doc """
  Creates a tax_rate.

  ## Examples

      iex> create_tax_rate(%{field: value})
      {:ok, %TaxRate{}}

      iex> create_tax_rate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tax_rate(attrs \\ %{}) do
    %TaxRate{}
    |> TaxRate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tax_rate.

  ## Examples

      iex> update_tax_rate(tax_rate, %{field: new_value})
      {:ok, %TaxRate{}}

      iex> update_tax_rate(tax_rate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tax_rate(%TaxRate{} = tax_rate, attrs) do
    tax_rate
    |> TaxRate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tax_rate.

  ## Examples

      iex> delete_tax_rate(tax_rate)
      {:ok, %TaxRate{}}

      iex> delete_tax_rate(tax_rate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tax_rate(%TaxRate{} = tax_rate) do
    Repo.delete(tax_rate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tax_rate changes.

  ## Examples

      iex> change_tax_rate(tax_rate)
      %Ecto.Changeset{data: %TaxRate{}}

  """
  def change_tax_rate(%TaxRate{} = tax_rate, attrs \\ %{}) do
    TaxRate.changeset(tax_rate, attrs)
  end
end
