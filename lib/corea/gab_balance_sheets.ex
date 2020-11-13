defmodule Corea.GABBalanceSheets do
  @moduledoc """
  The GABBalanceSheets context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GABBalanceSheets.GABBalanceSheet

  @doc """
  Returns the list of gab_balance_sheets.

  ## Examples

      iex> list_gab_balance_sheets()
      [%GABBalanceSheet{}, ...]

  """
  def list_gab_balance_sheets do
    Repo.all(GABBalanceSheet)
  end

  @doc """
  Gets a single gab_balance_sheet.

  Raises `Ecto.NoResultsError` if the Gab balance sheet does not exist.

  ## Examples

      iex> get_gab_balance_sheet!(123)
      %GABBalanceSheet{}

      iex> get_gab_balance_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gab_balance_sheet!(id), do: Repo.get!(GABBalanceSheet, id)

  @doc """
  Creates a gab_balance_sheet.

  ## Examples

      iex> create_gab_balance_sheet(%{field: value})
      {:ok, %GABBalanceSheet{}}

      iex> create_gab_balance_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gab_balance_sheet(attrs \\ %{}) do
    %GABBalanceSheet{}
    |> GABBalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gab_balance_sheet.

  ## Examples

      iex> update_gab_balance_sheet(gab_balance_sheet, %{field: new_value})
      {:ok, %GABBalanceSheet{}}

      iex> update_gab_balance_sheet(gab_balance_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gab_balance_sheet(%GABBalanceSheet{} = gab_balance_sheet, attrs) do
    gab_balance_sheet
    |> GABBalanceSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gab_balance_sheet.

  ## Examples

      iex> delete_gab_balance_sheet(gab_balance_sheet)
      {:ok, %GABBalanceSheet{}}

      iex> delete_gab_balance_sheet(gab_balance_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gab_balance_sheet(%GABBalanceSheet{} = gab_balance_sheet) do
    Repo.delete(gab_balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gab_balance_sheet changes.

  ## Examples

      iex> change_gab_balance_sheet(gab_balance_sheet)
      %Ecto.Changeset{data: %GABBalanceSheet{}}

  """
  def change_gab_balance_sheet(%GABBalanceSheet{} = gab_balance_sheet, attrs \\ %{}) do
    GABBalanceSheet.changeset(gab_balance_sheet, attrs)
  end
end
