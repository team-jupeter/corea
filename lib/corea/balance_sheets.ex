defmodule Corea.BalanceSheets do
  @moduledoc """
  The BalanceSheets context.
  """

  import Ecto.Query, warn: false
  alias Corea.Repo

  alias Corea.BalanceSheets.BalanceSheet

  @doc """
  Returns the list of balance_sheets.

  ## Examples

      iex> list_balance_sheets()
      [%BalanceSheet{}, ...]

  """
  def list_balance_sheets do
    Repo.all(BalanceSheet)
  end

  @doc """
  Gets a single balance_sheet.

  Raises `Ecto.NoResultsError` if the Balance sheet does not exist.

  ## Examples

      iex> get_balance_sheet!(123)
      %BalanceSheet{}

      iex> get_balance_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_balance_sheet!(id), do: Repo.get!(BalanceSheet, id)

  @doc """
  Creates a balance_sheet.

  ## Examples

      iex> create_balance_sheet(%{field: value})
      {:ok, %BalanceSheet{}}

      iex> create_balance_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_balance_sheet(attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a balance_sheet.

  ## Examples

      iex> update_balance_sheet(balance_sheet, %{field: new_value})
      {:ok, %BalanceSheet{}}

      iex> update_balance_sheet(balance_sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_balance_sheet(%BalanceSheet{} = balance_sheet, attrs) do
    balance_sheet
    |> BalanceSheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a balance_sheet.

  ## Examples

      iex> delete_balance_sheet(balance_sheet)
      {:ok, %BalanceSheet{}}

      iex> delete_balance_sheet(balance_sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_balance_sheet(%BalanceSheet{} = balance_sheet) do
    Repo.delete(balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking balance_sheet changes.

  ## Examples

      iex> change_balance_sheet(balance_sheet)
      %Ecto.Changeset{data: %BalanceSheet{}}

  """
  def change_balance_sheet(%BalanceSheet{} = balance_sheet, attrs \\ %{}) do
    BalanceSheet.changeset(balance_sheet, attrs)
  end
end
