defmodule Corea.SupulBalanceSheets do
  @moduledoc """
  The SupulBalanceSheets context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.SupulBalanceSheets.SupulBalanceSheet

  @doc """
  Returns the list of supul_balance_sheets.

  ## Examples

      iex> list_supul_balance_sheets()
      [%SupulBalanceSheet{}, ...]

  """
  def list_supul_balance_sheets do
    Repo.all(SupulBalanceSheet)
  end

  @doc """
  Gets a single supul_balance_sheet.

  Raises `Ecto.NoResultsError` if the Supul balance sheet does not exist.

  ## Examples

      iex> get_supul_balance_sheet!(123)
      %SupulBalanceSheet{}

      iex> get_supul_balance_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supul_balance_sheet!(id), do: Repo.get!(SupulBalanceSheet, id)

  @doc """
  Creates a supul_balance_sheet.

  ## Examples

      iex> create_supul_balance_sheet(%{field: value})
      {:ok, %SupulBalanceSheet{}}

      iex> create_supul_balance_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supul_balance_sheet(attrs \\ %{}) do
    %SupulBalanceSheet{}
    |> SupulBalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supul_balance_sheet.

  ## Examples

      iex> update_supul_balance_sheet(supul_balance_sheet, %{field: new_value})
      {:ok, %SupulBalanceSheet{}}

      iex> update_supul_balance_sheet(supul_balance_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supul_balance_sheet(%SupulBalanceSheet{} = supul_balance_sheet, attrs) do
    supul_balance_sheet
    |> SupulBalanceSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supul_balance_sheet.

  ## Examples

      iex> delete_supul_balance_sheet(supul_balance_sheet)
      {:ok, %SupulBalanceSheet{}}

      iex> delete_supul_balance_sheet(supul_balance_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supul_balance_sheet(%SupulBalanceSheet{} = supul_balance_sheet) do
    Repo.delete(supul_balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supul_balance_sheet changes.

  ## Examples

      iex> change_supul_balance_sheet(supul_balance_sheet)
      %Ecto.Changeset{data: %SupulBalanceSheet{}}

  """
  def change_supul_balance_sheet(%SupulBalanceSheet{} = supul_balance_sheet, attrs \\ %{}) do
    SupulBalanceSheet.changeset(supul_balance_sheet, attrs)
  end
end
