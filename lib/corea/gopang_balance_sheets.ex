defmodule Corea.GopangBalanceSheets do
  @moduledoc """
  The GopangBalanceSheets context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.GopangBalanceSheets.GopangBalanceSheet

  @doc """
  Returns the list of gopang_balance_sheets.

  ## Examples

      iex> list_gopang_balance_sheets()
      [%GopangBalanceSheet{}, ...]

  """
  def list_gopang_balance_sheets do
    Repo.all(GopangBalanceSheet)
  end

  @doc """
  Gets a single gopang_balance_sheet.

  Raises `Ecto.NoResultsError` if the Gopang balance sheet does not exist.

  ## Examples

      iex> get_gopang_balance_sheet!(123)
      %GopangBalanceSheet{}

      iex> get_gopang_balance_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gopang_balance_sheet!(id), do: Repo.get!(GopangBalanceSheet, id)

  @doc """
  Creates a gopang_balance_sheet.

  ## Examples

      iex> create_gopang_balance_sheet(%{field: value})
      {:ok, %GopangBalanceSheet{}}

      iex> create_gopang_balance_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gopang_balance_sheet(attrs \\ %{}) do
    %GopangBalanceSheet{}
    |> GopangBalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gopang_balance_sheet.

  ## Examples

      iex> update_gopang_balance_sheet(gopang_balance_sheet, %{field: new_value})
      {:ok, %GopangBalanceSheet{}}

      iex> update_gopang_balance_sheet(gopang_balance_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gopang_balance_sheet(%GopangBalanceSheet{} = gopang_balance_sheet, attrs) do
    gopang_balance_sheet
    |> GopangBalanceSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gopang_balance_sheet.

  ## Examples

      iex> delete_gopang_balance_sheet(gopang_balance_sheet)
      {:ok, %GopangBalanceSheet{}}

      iex> delete_gopang_balance_sheet(gopang_balance_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gopang_balance_sheet(%GopangBalanceSheet{} = gopang_balance_sheet) do
    Repo.delete(gopang_balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gopang_balance_sheet changes.

  ## Examples

      iex> change_gopang_balance_sheet(gopang_balance_sheet)
      %Ecto.Changeset{data: %GopangBalanceSheet{}}

  """
  def change_gopang_balance_sheet(%GopangBalanceSheet{} = gopang_balance_sheet, attrs \\ %{}) do
    GopangBalanceSheet.changeset(gopang_balance_sheet, attrs)
  end
end
